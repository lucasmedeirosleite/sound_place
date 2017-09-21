defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.PlaylistView

  def render("playlists.json", %{playlists: playlists}) do
    %{data: render_many(playlists, PlaylistView, "playlist.json")}
  end
end
