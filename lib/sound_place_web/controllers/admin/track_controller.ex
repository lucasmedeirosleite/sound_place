defmodule SoundPlaceWeb.Admin.TrackController do
  use SoundPlaceWeb, :controller

  alias SoundPlace.Media
  alias SoundPlace.Media.Track

  plug :put_artist
  plug :put_album
  plug :put_genres when action in [:new, :edit]

  def index(conn, %{"album_id" => album_id}) do
    tracks = Media.list_tracks(album_id: album_id)
    render(conn, :index, tracks: tracks)
  end

  def new(conn, _params) do
    changeset = Media.change_track(%Track{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"album_id" => album_id, "track" => track_params}) do
    track_params = Map.put(track_params, "album_id", album_id)

    with {:ok, track} <- Media.create_track(track_params) do
      conn
      |> put_flash(:info, "#{track.song.name} created")
      |> redirect(to: admin_artist_album_track_path(conn, :index, conn.assigns.artist, conn.assigns.album))

    else {:error, %Ecto.Changeset{} = changeset} ->
      conn
      |> put_genres()
      |> render(:new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    track = Media.get_track!(id)
    changeset = Media.change_track(track)
    render(conn, :edit, track: track, changeset: changeset)
  end

  def update(conn, %{"album_id" => album_id, "id" => id, "track" => track_params}) do
    track_params = Map.put(track_params, "album_id", album_id)
    track = Media.get_track!(id)

    with {:ok, track} <- Media.update_track(track, track_params) do
      conn
      |> put_flash(:info, "#{track.song.name} updated")
      |> redirect(to: admin_artist_album_track_path(conn, :index, conn.assigns.artist, conn.assigns.album))

    else {:error,  %Ecto.Changeset{} = changeset} ->
      conn
      |> put_genres()
      |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Media.get_track!(id)
    {:ok, _track} = Media.delete_track(track)

    conn
    |> put_flash(:info, "Track deleted successfully.")
    |> redirect(to: admin_artist_album_track_path(conn, :index, conn.assigns.artist, conn.assigns.album))
  end

  defp put_artist(conn, _) do
    artist =
      conn.params["artist_id"]
      |> Media.get_artist!()

    assign(conn, :artist, artist)
  end

  defp put_album(conn, _) do
    album =
      conn.params["album_id"]
      |> Media.get_album!()

    assign(conn, :album, album)
  end

  defp put_genres(conn, _), do: put_genres(conn)
  defp put_genres(conn) do
    genres = Media.list_genres()
    assign(conn, :genres, genres)
  end
end
