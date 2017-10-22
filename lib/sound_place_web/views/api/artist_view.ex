defmodule SoundPlaceWeb.API.ArtistView do
  use SoundPlaceWeb, :view

  def render("artist.json", %{artist: artist}) do
    id = artist[:id] || artist.spotify_id
    %{id: id, name: artist.name, cover: artist.image, genres: artist.genres}
  end
end
