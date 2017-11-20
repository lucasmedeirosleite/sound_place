defmodule SoundPlaceWeb.API.PlaylistView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.TrackView

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.spotify_id, name: playlist.name, cover: playlist.cover}
  end

  def render("tracks.json", %{ playlist: playlist }) do
    %{
      data: %{
        id: playlist.spotify_id,
        name: playlist.name,
        cover: playlist.cover,
        tracks: render_many(playlist.tracks, TrackView, "track.json")
      }
    }
  end
end
