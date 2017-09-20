defmodule SoundPlaceWeb.API.Fallback.UserController do
  use Phoenix.Controller

  def call(conn, {:error, :import_failed}) do
    conn
    |> put_status(500)
    |> json(%{message: "Unable to import user playlists"})
  end
  
  def call(conn, {:error, _}) do
    conn
    |> put_status(500)
    |> json(%{message: "Unexpected error when trying to fetch user data"})
  end
end