defmodule SoundPlaceWeb.SessionController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Admin

  plug :put_layout, "sign_in.html"

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"credential" => %{"email" => email, "password" => password}}) do
    case Admin.authenticate_by(email: email, password: password) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Welcome, #{user.name}")
        |> redirect(to: admin_dashboard_path(conn, :index))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render(:new)
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: admin_dashboard_path(conn, :index))
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in to access this page")
    |> redirect(to: session_path(conn, :new))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: session_path(conn, :new))
  end
end
