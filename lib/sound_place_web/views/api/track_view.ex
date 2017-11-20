defmodule SoundPlaceWeb.API.TrackView do
  use SoundPlaceWeb, :view

  def render("track.json", %{track: track}) do
    artist = List.first(track.album.artists)
    %{
      id: track.id,
      sequence: track.sequence,
      duration: track.song.duration,
      explicit: track.song.explicit,
      name: track.song.name,
      spotify_id: track.song.spotify_id,
      album: %{
        id: track.album.id,
        name: track.album.name,
        cover: track.album.cover
      },
      artist: %{
        id: artist.id,
        name: artist.name,
        image: artist.image
      }
    }
  end
end
