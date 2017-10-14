defmodule SoundPlace.Provider do
  alias SoundPlace.Accounts
  alias SoundPlace.Provider.SpotifyProvider

  def authorization_url, do: SpotifyProvider.authorization_url

  def authenticate(conn, params), do: SpotifyProvider.authenticate(conn, params)

  def credentials(conn), do: SpotifyProvider.credentials(conn)

  def refresh_token(cred) do
    with {:ok, new_token} <- SpotifyProvider.refresh_token(cred),
         {:ok, new_cred} <- Accounts.update_credential(cred, %{access_token: new_token}) do
      new_cred
    else {:error, _} ->
      raise "Unable to refresh user access token"
    end
  end

  def profile(conn), do: SpotifyProvider.profile(conn)
  def profile(conn, user_id), do: SpotifyProvider.profile(conn, user_id)

  def profile_map(profile, credentials), do: SpotifyProvider.profile_map(profile, credentials)

  def user_params(conn), do: SpotifyProvider.user_params(conn)

  def all_playlists(cred) do
    all_playlists(cred, cred.spotify_id)
  end

  def all_playlists(cred, user_id) do
    perform_provider_call(cred, [offset: 0, accumulated: []], fn(offset, current_credentials) ->
      params = [fields: "items(id, name, images)", limit: 20, offset: offset]
      SpotifyProvider.playlists(current_credentials, user_id, params)
    end) 
  end

  def all_tracks(credentials, playlists) do
    result = Enum.map(playlists, fn(playlist) ->
      case playlist_tracks(credentials, playlist.id) do
        {:ok, tracks} ->
          {playlist.id, tracks} 
        _ ->
          {playlist.id, []}
      end
    end)

    {:ok, result}
  end

  def playlist_tracks(cred, playlist_id) do
    playlist_tracks(cred, cred.spotify_id, playlist_id)
  end

  def playlist_tracks(cred, user_id, playlist_id) do
    perform_provider_call(cred, [offset: 0, accumulated: []], fn(offset, updated_credentials) ->
      params = [fields: "next,items(track(id,name,duration_ms,explicit,track_number, artists(id),album(id)))", 
                limit: 20, 
                offset: offset]
      
      SpotifyProvider.playlist_tracks(updated_credentials, user_id, playlist_id, params)
    end)
  end

  def all_albums(credentials, tracks) do
    albums = 
      tracks 
      |> Enum.map(fn({_, playlist_tracks}) -> 
           Enum.map(playlist_tracks, fn(playlist_track) -> playlist_track.track.album["id"] end) 
         end) 
      |> List.flatten
      |> Enum.reject(&is_nil/1)
      |> Enum.uniq
      |> Enum.chunk_every(20)

    result = Enum.map(albums, fn(album_ids) ->
      {:ok, albums} = albums(credentials, album_ids)
      albums
    end) |> List.flatten

    {:ok, result}
  end

  def albums(credentials, ids \\ []) do
    perform_provider_call(credentials, [offset: 0, accumulated: []], fn(_offset, updated_credentials) ->
      ids = Enum.join(ids, ",")
      SpotifyProvider.albums(updated_credentials, ids: ids)
    end)
  end

  def all_album_types(albums) do
    result = albums
    |> Enum.map(&(&1.album_type))
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq

    {:ok, result}
  end

  def all_labels(albums) do
    result = albums
    |> Enum.map(&(&1.label))
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq

    {:ok, result}
  end

  def all_artists(credentials, albums) do
    artists = 
      albums 
      |> Enum.map(fn(album) -> 
           Enum.map(album.artists, fn(artist) -> artist["id"] end) 
         end) 
      |> List.flatten
      |> Enum.reject(&is_nil/1)
      |> Enum.uniq
      |> Enum.chunk_every(20)

    result = Enum.map(artists, fn(artist_ids) ->
      {:ok, artists} = artists(credentials, artist_ids)
      artists
    end) |> List.flatten

    {:ok, result}
  end

  def artists(credentials, ids \\ []) do
    perform_provider_call(credentials, [offset: 0, accumulated: []], fn(_offset, updated_credentials) ->
      ids = Enum.join(ids, ",")
      SpotifyProvider.artists(updated_credentials, ids: ids)
    end)
  end

  def all_genres(artists) do
    result = artists
    |> Enum.map(&(&1.genres))
    |> List.flatten
    |> Enum.uniq

    {:ok, result}
  end

  defp perform_provider_call(_cred, [offset: nil, accumulated: accumulated], _func)
  when is_list(accumulated), do: {:ok, accumulated}

  defp perform_provider_call(cred, [offset: offset, accumulated: accumulated], func) do
    with {:ok, response} <- func.(offset, cred),
         {response, offset} <- extract_offset(accumulated, response) do

      perform_provider_call(cred, [offset: offset, accumulated: response], func)
    else 
      {:error, :expired_token} ->
        new_credentials = refresh_token(cred)
        perform_provider_call(new_credentials, [offset: offset, accumulated: accumulated], func)
      {:error, :not_found} ->
        {:error, :resource_not_found}
      {:error, :rate_limit} ->
        {:error, :rate_limit_exceeded}
      :error ->
        {:error, :unknown_error}
    end
  end

  defp extract_offset(accumulated, data) when is_list(data), do: {accumulated++data, nil}
  defp extract_offset(accumulated, %Paging{items: data, next: nil}), do: {accumulated++data, nil}
  defp extract_offset(accumulated, %Paging{items: data, next: next}) do
    offset = 
     next 
     |> String.split("&") 
     |> List.first 
     |> String.split("=") 
     |> List.last 
     |> String.to_integer
    
    {accumulated ++ data, offset}
  end
end
