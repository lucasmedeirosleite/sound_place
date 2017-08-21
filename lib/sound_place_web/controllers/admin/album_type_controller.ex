defmodule SoundPlaceWeb.Admin.AlbumTypeController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.AlbumType

  def index(conn, _params) do
    album_types = Media.list_album_types()
    render(conn, :index, album_types: album_types)
  end

  def new(conn, _params) do
    changeset = Media.change_album_type(%AlbumType{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"album_type" => album_types_params}) do
    with {:ok, album_type} <- Media.create_album_type(album_types_params) do
      conn
      |> put_flash(:info, "#{album_type.name} created")
      |> redirect(to: admin_album_type_path(conn, :index))
    else {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    album_type = Media.get_album_type!(id)
    changeset = Media.change_album_type(album_type)
    render(conn, "edit.html", album_type: album_type, changeset: changeset)
  end

  def update(conn, %{"id" => id, "album_type" => album_type_params}) do
    album_type = Media.get_album_type!(id)

    with {:ok, album_type} <- Media.update_album_type(album_type, album_type_params) do
      conn
      |> put_flash(:info, "#{album_type.name} updated")
      |> redirect(to: admin_album_type_path(conn, :index))
    else {:error,  %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", album_type: album_type, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    album_type = Media.get_album_type!(id)
    {:ok, _album_type} = Media.delete_album_type(album_type)

    conn
    |> put_flash(:info, "Album type deleted successfully.")
    |> redirect(to: admin_album_type_path(conn, :index))
  end
end
