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
end
