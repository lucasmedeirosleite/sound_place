defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view
  alias SoundPlaceWeb.API.UserView

  def render("playlists.json", %{playlists: playlists}) do
    %{data: playlists}
  end
end
