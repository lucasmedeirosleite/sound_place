defmodule SoundPlaceWeb.API.PlaylistView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.TrackView

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.spotify_id, name: playlist.name, cover: playlist.cover}
  end

  def render("tracks.json", %{ tracks: tracks }) do
    %{data: render_many(tracks, TrackView, "track.json")}
  end
end
