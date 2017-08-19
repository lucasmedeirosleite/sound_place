defmodule SoundPlaceWeb.Admin.GenreController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.Genre

  def index(conn, _params) do
    genres = Media.list_genres()
    render(conn, :index, genres: genres)
  end

  def new(conn, _params) do
    changeset = Media.change_genre(%Genre{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"genre" => genre_params}) do
    with {:ok, genre} <- Media.create_genre(genre_params) do
      conn
      |> put_flash(:info, "#{genre.name} created")
      |> redirect(to: admin_genre_path(conn, :index))
    else {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    genre = Media.get_genre!(id)
    changeset = Media.change_genre(genre)
    render(conn, "edit.html", genre: genre, changeset: changeset)
  end

  def update(conn, %{"id" => id, "genre" => genre_params}) do
    genre = Media.get_genre!(id)

    with {:ok, genre} <- Media.update_genre(genre, genre_params) do
      conn
      |> put_flash(:info, "#{genre.name} updated")
      |> redirect(to: admin_genre_path(conn, :index))
    else {:error,  %Ecto.Changeset{} = changeset} ->
      render(conn, "edit.html", genre: genre, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    genre = Media.get_genre!(id)
    {:ok, _genre} = Media.delete_genre(genre)

    conn
    |> put_flash(:info, "Genre deleted successfully.")
    |> redirect(to: admin_genre_path(conn, :index))
  end
end
