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

  def playlists(cred) do
    playlists(cred, cred.spotify_id)
  end

  def playlists(cred, user_id) do
    all_playlists(cred, user_id, offset: 0, accumulated: [])
  end

  defp all_playlists(_cred, _user_id, [offset: nil, accumulated: accumulated]) 
  when is_list(accumulated), do: {:ok, accumulated}

  defp all_playlists(cred, user_id, [offset: offset, accumulated: accumulated]) do
    params = [fields: "items(id, name, images)", limit: 20, offset: offset]

    with {:ok, playlists} <- SpotifyProvider.playlists(cred, user_id, params),
         {playlists, offset} <- extract_offset(accumulated, playlists) do
      
      all_playlists(cred, user_id, offset: offset, accumulated: playlists)
    else {:error, :expired_token} ->
      refreshed_credentials = refresh_token(cred)
      playlists(refreshed_credentials, user_id)
    end
  end

  defp extract_offset(accumulated, %Paging{items: playlists, next: nil}), do: {accumulated++playlists, nil}
  defp extract_offset(accumulated, %Paging{items: playlists, next: next}) do
    offset = 
     next 
     |> String.split("&") 
     |> List.first 
     |> String.split("=") 
     |> List.last 
     |> String.to_integer
    
    {accumulated ++ playlists, offset}
  end
end
