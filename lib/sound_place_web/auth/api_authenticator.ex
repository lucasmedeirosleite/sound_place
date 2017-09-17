defmodule SoundPlaceWeb.APIAuthenticator do
  defmodule Credentials do
    defstruct token: nil, exp: nil, callback_url: nil
  end

  alias SoundPlaceWeb.APIAuthenticator.Credentials

  @default_callback_url Application.get_env(:sound_place, :web_app_url)

  def authenticate(conn, user, url \\ @default_callback_url) do
    new_conn = Guardian.Plug.api_sign_in(conn, user)

    case Guardian.Plug.current_token(new_conn) do
      nil ->
        {:error, new_conn, :unavailable_token, url}
      "" ->
        {:error, new_conn, :invalid_token, url}
      jwt ->
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")
        url = "#{url}?success=true&access_token=#{jwt}&exp=#{exp}"

        credentials = %Credentials{token: jwt, exp: "#{exp}", callback_url: url}
        {:ok, new_conn, credentials}
    end
  end
end
