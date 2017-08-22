defmodule SoundPlaceWeb.Admin.ArtistController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.Artist

  def index(conn, _params) do
    artists = Media.list_artists()
    render(conn, :index, artists: artists)
  end

  def new(conn, _params) do
    changeset = Media.change_artist(%Artist{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"artist" => artist_params}) do
    with {:ok, artist} <- Media.create_artist(artist_params) do
      conn
      |> put_flash(:info, "#{artist.name} created")
      |> redirect(to: admin_artist_path(conn, :index))
    else {:error, %Ecto.Changeset{} = changeset} ->
      render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    artist = Media.get_artist!(id)
    changeset = Media.change_artist(artist)
    render(conn, :edit, artist: artist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "artist" => artist_params}) do
    artist = Media.get_artist!(id)

    with {:ok, artist} <- Media.update_artist(artist, artist_params) do
      conn
      |> put_flash(:info, "#{artist.name} updated")
      |> redirect(to: admin_artist_path(conn, :index))
    else {:error,  %Ecto.Changeset{} = changeset} ->
      render(conn, :edit, artist: artist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    artist = Media.get_artist!(id)
    {:ok, _artist} = Media.delete_artist(artist)

    conn
    |> put_flash(:info, "Artist deleted successfully.")
    |> redirect(to: admin_artist_path(conn, :index))
  end
end
