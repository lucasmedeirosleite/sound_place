defmodule SoundPlaceWeb.Admin.AlbumController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.Album

  plug :put_artist
  plug :put_collections when action in [:new, :edit]

  def index(conn, %{"artist_id" => artist_id}) do
    albums = Media.list_albums(artist_id: artist_id)
    render(conn, :index, albums: albums)
  end

  def new(conn, _params) do
    changeset = Media.change_album(%Album{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"artist_id" => artist_id, "album" => album_params}) do
    album_params = Map.put(album_params, "artists", [artist_id])

    with {:ok, album} <- Media.create_album(album_params) do
      conn
      |> put_flash(:info, "#{album.name} created")
      |> redirect(to: admin_artist_album_path(conn, :index, conn.assigns.artist))

    else {:error, %Ecto.Changeset{} = changeset} ->
      conn
      |> put_collections()
      |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    album = Media.get_album!(id)
    changeset = Media.change_album(album)
    render(conn, :edit, album: album, changeset: changeset)
  end

  def update(conn, %{"artist_id" => artist_id, "id" => id, "album" => album_params}) do
    album_params = Map.put(album_params, "artists", [artist_id])
    album = Media.get_album!(id)

    with {:ok, album} <- Media.update_album(album, album_params) do
      conn
      |> put_flash(:info, "#{album.name} updated")
      |> redirect(to: admin_artist_album_path(conn, :index, conn.assigns.artist))

    else {:error,  %Ecto.Changeset{} = changeset} ->
      conn
      |> put_collections()
      |> render(:edit, album: album, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    album = Media.get_album!(id)
    {:ok, _album} = Media.delete_album(album)

    conn
    |> put_flash(:info, "Album deleted successfully.")
    |> redirect(to: admin_artist_album_path(conn, :index, conn.assigns.artist))
  end

  # Plugs

  defp put_artist(conn, _) do
    artist = Media.get_artist!(conn.params["artist_id"])
    assign(conn, :artist, artist)
  end

  defp put_collections(conn, _), do: put_collections(conn)
  defp put_collections(conn) do
    genres = Media.list_genres()
    labels = Media.list_labels()
    album_types = Media.list_album_types()

    conn
    |> assign(:genres, genres)
    |> assign(:labels, labels)
    |> assign(:album_types, album_types)
  end
end
