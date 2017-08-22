defmodule SoundPlace.Media do
  import Ecto.Query, warn: false
  alias SoundPlace.Repo

  alias SoundPlace.Media.{Genre, Label, AlbumType, Artist}

  # Genres

  def list_genres do
    Repo.all(Genre)
  end

  def get_genre!(id), do: Repo.get!(Genre, id)

  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  def change_genre(%Genre{} = genre) do
    Genre.changeset(genre, %{})
  end

  # Labels

  def list_labels do
    Repo.all(Label)
  end

  def get_label!(id), do: Repo.get!(Label, id)

  def create_label(attrs \\ %{}) do
    %Label{}
    |> Label.changeset(attrs)
    |> Repo.insert()
  end

  def update_label(%Label{} = label, attrs) do
    label
    |> Label.changeset(attrs)
    |> Repo.update()
  end

  def delete_label(%Label{} = label) do
    Repo.delete(label)
  end

  def change_label(%Label{} = label) do
    Label.changeset(label, %{})
  end

  # Album types

  def list_album_types do
    Repo.all(AlbumType)
  end

  def get_album_type!(id), do: Repo.get!(AlbumType, id)

  def create_album_type(attrs \\ %{}) do
    %AlbumType{}
    |> AlbumType.changeset(attrs)
    |> Repo.insert()
  end

  def update_album_type(%AlbumType{} = album_type, attrs) do
    album_type
    |> AlbumType.changeset(attrs)
    |> Repo.update()
  end

  def delete_album_type(%AlbumType{} = album_type) do
    Repo.delete(album_type)
  end

  def change_album_type(%AlbumType{} = album_type) do
    AlbumType.changeset(album_type, %{})
  end

  # Artists

  def list_artists do
    Repo.all(Artist)
  end

  def get_artist!(id), do: Repo.get!(Artist, id)

  def create_artist(attrs \\ %{}) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
  end

  def update_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> Repo.update()
  end

  def delete_artist(%Artist{} = artist) do
    Repo.delete(artist)
  end

  def change_artist(%Artist{} = artist) do
    Artist.changeset(artist, %{})
  end
end
