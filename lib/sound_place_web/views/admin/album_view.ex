defmodule SoundPlaceWeb.Admin.AlbumView do
  use SoundPlaceWeb, :view

  def collection_data(data) do
    Enum.map(data, &{&1.name, &1.id})
  end

  def album_type(album) do
    if album.album_type do
      album.album_type.name
    else
      ""
    end
  end

  def genre_selected?(%Ecto.Association.NotLoaded{}), do: [0]
  def genre_selected?(genres), do: Enum.map(genres, &(&1.id))

  def genres_representation(genres) do
    Enum.map(genres, &({&1.name, &1.id}))
  end
end
