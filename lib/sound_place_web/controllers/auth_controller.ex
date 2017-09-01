defmodule SoundPlaceWeb.AuthController do
  use SoundPlaceWeb, :controller

  alias SoundPlaceWeb.SpotifyBridge
  alias SoundPlace.Accounts

  def spotify(conn, _params) do
    redirect(conn, external: SpotifyBridge.authorization_url)
  end

  def callback(conn, params) do
    url = Application.get_env(:sound_place, :web_app_url)

    with {:ok, conn} <- SpotifyBridge.authenticate(conn, params),
         {:ok, credentials} <- SpotifyBridge.credentials(conn),
         {:ok, profile} <- SpotifyBridge.profile(conn),
         {:ok, profile_params} <- SpotifyBridge.profile_map(profile, credentials),
         {:ok, user} <- Accounts.create_user(profile_params) do

      IO.puts "******** USER: #{inspect(user)}"

      url = "#{url}?success=true&access_token=#{user.spotify_credential.access_token}"
      redirect(conn, external: url)
    else _ ->
      url = "#{url}?success=false"
      redirect(conn, external: url)
    end
  end
end
