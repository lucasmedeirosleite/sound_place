defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.UserView

  def render("playlists.json", %{playlists: playlists}) do
    %{data: render_many(playlists, UserView, "playlist.json")}
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{
      id: playlist.id,
      name: playlist.name,
      cover: playlist.cover
    }
  end
end
