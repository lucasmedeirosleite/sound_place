defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view

  def render("playlists.json", %{playlists: playlists}) do
    %{data: playlists}
  end
end
