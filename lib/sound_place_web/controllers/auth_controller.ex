defmodule SoundPlaceWeb.AuthController do
  use SoundPlaceWeb, :controller

  plug :put_layout, "sign_in.html"

  def spotify(conn, _params) do
    redirect(conn, external: Spotify.Authorization.url)
  end

  def callback(conn, params) do
    url = Application.get_env(:sound_place, :web_app_url)

    with {:ok, _credentials} <- Spotify.Authentication.authenticate(conn, params) do
      url = "#{url}?success=true"
      redirect(conn, external: url)
    else _ ->
      url = "#{url}?success=false"
      redirect(conn, external: url)
    end
  end
end
