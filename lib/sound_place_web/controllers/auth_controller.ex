defmodule SoundPlaceWeb.AuthController do
  use SoundPlaceWeb, :controller

  alias SoundPlaceWeb.APIAuthenticator
  alias SoundPlaceWeb.SpotifyBridge
  alias SoundPlace.Accounts

  @callback_url Application.get_env(:sound_place, :web_app_url)

  def spotify(conn, _params) do
    redirect(conn, external: SpotifyBridge.authorization_url)
  end

  def callback(conn, params) do
    with {:ok, spotify_conn} <- SpotifyBridge.authenticate(conn, params),
         {:ok, user_params} <- SpotifyBridge.user_params(spotify_conn),
         {:ok, user} <- Accounts.save_user(user_params),
         {:ok, sound_place_conn, credentials} <- APIAuthenticator.authenticate(spotify_conn, user) do

      sound_place_conn
      |> put_resp_header("authorization", "Bearer #{credentials.token}")
      |> put_resp_header("x-expires", "#{credentials.exp}")
      |> redirect(external: credentials.callback_url)
    else
      {:error, error_conn, _, url} ->
        redirect(error_conn, external: url)
      _ ->
        url = "#{@callback_url}?success=false"
        redirect(conn, external: url)
    end
  end
end
