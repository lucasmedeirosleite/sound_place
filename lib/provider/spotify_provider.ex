defmodule SoundPlace.Provider.SpotifyProvider do
  alias Spotify.{Authentication, Authorization, Credentials, Profile, Playlist}

  def authorization_url, do: Authorization.url

  def authenticate(conn, params) do
    Authentication.authenticate(conn, params)
  rescue
    e in AuthenticationError -> {:error, e.message}
  end

  def credentials(conn), do: {:ok, Credentials.new(conn)}

  def refresh_token(credentials) do
    spotify_credentials = Credentials.new(credentials.access_token, credentials.refresh_token)

    case Authentication.refresh(spotify_credentials) do
      {:ok, new_credentials} ->
        IO.inspect("***** REFRESHED TOKEN: #{inspect(new_credentials.access_token)}")
        {:ok, new_credentials.access_token}
      error ->
        IO.inspect("***** ERROR on refresh: #{inspect(error)}")
        {:error, :failed_to_refresh_token}
    end
  end

  def profile(conn), do: Profile.me(conn)
  def profile(conn, user_id), do: Profile.user(conn, user_id)

  def profile_map(%Spotify.Profile{} = profile, %Spotify.Credentials{} = credentials) do
    params =
      %{}
      |> Map.put("name",  profile.display_name)
      |> Map.put("email", profile.email)
      |> Map.put("image", List.first(profile.images)["url"])
      |> Map.put("spotify_credential",
         %{}
         |> Map.put("spotify_id", profile.id)
         |> Map.put("access_token", credentials.access_token)
         |> Map.put("refresh_token", credentials.refresh_token)
      )

    {:ok, params}
  end

  def user_params(conn) do
    with {:ok, credentials} <- credentials(conn),
         {:ok, profile} <- profile(conn) do
      profile_map(profile, credentials)
    else _ ->
      {:error, :invalid_user_params}
    end
  end

  def albums(credentials, ids: ids) do
    perform_call(credentials, fn(credentials) ->
      Spotify.Album.get_albums(credentials, ids: ids)
    end) 
  end

  def artists(credentials, ids: ids) do
    perform_call(credentials, fn(credentials) ->
      Spotify.Artist.get_artists(credentials, ids: ids)
    end)
  end

  def playlists(credentials, user_id, params) do
    perform_call(credentials, fn(cred) ->
      Playlist.get_users_playlists(cred, user_id, params)
    end)
  end

  def playlist_tracks(credentials, user_id, playlist_id, params) do
    perform_call(credentials, fn(credentials) ->
      Playlist.get_playlist_tracks(credentials, user_id, playlist_id, params)
    end)
  end

  defp perform_call(credentials, func) do
    credentials = Credentials.new(credentials.access_token, credentials.refresh_token)

    case func.(credentials) do
      {:ok, %{"error" => %{"message" => "The access token expired", "status" => 401}}} ->
        {:error, :expired_token}
      {:ok, %{"error" => %{"message" => "Not found.", "status" => 404}}} ->
        {:error, :not_found}
      {:ok, %{"error" => %{"message" => "API rate limit exceeded", "status" => 429}}}
        {:error, :rate_limit}
      {:ok, response} ->
        {:ok, response}
      {:error, _} ->
        :error
    end
  end
end
