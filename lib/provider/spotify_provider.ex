defmodule SoundPlace.Provider.SpotifyProvider do
  alias Spotify.{Authentication, Authorization, Credentials, Profile, Playlist}

  def authorization_url do
    Authorization.url
  end

  def authenticate(conn, params) do
    Authentication.authenticate(conn, params)
  rescue
    e in AuthenticationError -> {:error, e.message}
  end

  def credentials(conn) do
    {:ok, Credentials.new(conn)}
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

  def playlists(credentials, user_id, params) do
    credentials = Credentials.new(credentials.access_token, credentials.refresh_token)
    Playlist.get_users_playlists(credentials, user_id, params)
  end
end
