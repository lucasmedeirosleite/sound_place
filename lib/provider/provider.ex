defmodule SoundPlace.Provider do
  alias SoundPlace.Accounts
  alias SoundPlace.Provider.SpotifyProvider

  def authorization_url, do: SpotifyProvider.authorization_url

  def authenticate(conn, params), do: SpotifyProvider.authenticate(conn, params)

  def credentials(conn), do: SpotifyProvider.credentials(conn)

  def profile(conn), do: SpotifyProvider.profile(conn)
  def profile(conn, user_id), do: SpotifyProvider.profile(conn, user_id)

  def profile_map(profile, credentials), do: SpotifyProvider.profile_map(profile, credentials)

  def user_params(conn), do: SpotifyProvider.user_params(conn)

  def playlists(cred, params \\ [limit: 50]) do
    with {:ok, playlists} <- SpotifyProvider.playlists(cred, cred.spotify_id, params) do
      {:ok, playlists}
    else {:error, :expired_token} ->
      refreshed_credentials = refresh_token(cred)
      playlists(refreshed_credentials)
    end
  end

  defp refresh_token(cred) do
    with {:ok, new_token} <- SpotifyProvider.refresh_token(cred),
         {:ok, new_cred} <- Accounts.update_credential(cred, %{access_token: new_token}) do
      new_cred
    else {:error, _} ->
      raise "Unable to refresh user access token"
    end
  end
end
