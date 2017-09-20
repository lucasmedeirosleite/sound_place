defmodule SoundPlaceWeb.AuthController do
  use SoundPlaceWeb, :controller

  alias SoundPlaceWeb.APIAuthenticator
  alias SoundPlace.Provider
  alias SoundPlace.Accounts

  action_fallback SoundPlaceWeb.Fallback.AuthController

  def spotify(conn, _params) do
    redirect(conn, external: Provider.authorization_url)
  end

  def callback(conn, params) do
    with {:ok, provider_conn} <- Provider.authenticate(conn, params),
         {:ok, user_params}   <- Provider.user_params(provider_conn),
         {:ok, user} <- Accounts.save_user(user_params),
         {:ok, sound_place_conn, credentials} <- APIAuthenticator.authenticate(provider_conn, user) do

      sound_place_conn
      |> put_resp_header("authorization", "Bearer #{credentials.token}")
      |> put_resp_header("x-expires", "#{credentials.exp}")
      |> redirect(external: credentials.callback_url)
    end
  end
end
