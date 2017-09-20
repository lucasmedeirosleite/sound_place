defmodule SoundPlaceWeb.Fallback.AuthController do
  use Phoenix.Controller

  def call(_conn, {:error, error_connection, _, url}) do
    redirect(error_connection, external: url)
  end

  def call(conn, {:error, _}) do
    url = "#{callback_url()}?success=false"
    redirect(conn, external: url)
  end

  defp callback_url do
    Application.get_env(:sound_place, :web_app_url)
  end
end