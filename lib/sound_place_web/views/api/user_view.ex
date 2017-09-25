defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.PlaylistView

  def render("me.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email,
      image: user.image
    }
  end

  def render("playlists.json", %{playlists: playlists}) do
    %{data: render_many(playlists, PlaylistView, "playlist.json")}
  end
end
