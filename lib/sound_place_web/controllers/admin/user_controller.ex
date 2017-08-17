defmodule SoundPlaceWeb.Admin.UserController do
  use SoundPlaceWeb, :controller
  alias SoundPlace.Admin

  alias SoundPlace.Admin
  alias SoundPlace.Admin.User

  plug :scrub_params, "user" when action in [:create]

  def index(conn, _params) do
    users = Admin.list_users()
    render(conn, :index, users: users)
  end

  def new(conn, _params) do
    changeset = Admin.change_user(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, _user} <- Admin.create_user(user_params) do
      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: admin_user_path(conn, :index))
    else {:error, %Ecto.Changeset{} = changeset} -> 
      render(conn, :new, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admin.get_user!(id)
    {:ok, _user} = Admin.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_user_path(conn, :index))
  end
end
