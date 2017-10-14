defmodule SoundPlaceWeb.API.PlaylistView do
  use SoundPlaceWeb, :view

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.spotify_id, name: playlist.name, cover: playlist.cover}
  end
end
