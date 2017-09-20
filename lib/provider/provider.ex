defmodule SoundPlace.Provider do
  alias SoundPlace.Provider.SpotifyProvider

  def authorization_url, do: SpotifyProvider.authorization_url

  def authenticate(conn, params), do: SpotifyProvider.authenticate(conn, params)

  def credentials(conn), do: SpotifyProvider.credentials(conn)

  def profile(conn), do: SpotifyProvider.profile(conn)
  def profile(conn, user_id), do: SpotifyProvider.profile(conn, user_id)

  def profile_map(profile, credentials), do: SpotifyProvider.profile_map(profile, credentials)

  def user_params(conn), do: SpotifyProvider.user_params(conn)

  def playlists(credentials, user_id, params \\ []) do
    SpotifyProvider.playlists(credentials, user_id, params)
  end
end
