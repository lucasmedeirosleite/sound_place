defmodule SoundPlaceWeb.API.UserView do
  use SoundPlaceWeb, :view

  def render("playlists.json", %{playlists: playlists}) do
    %{data: Enum.map(playlists, &playlist_view/1)}
  end

  defp playlist_view(playlist) do
    %{
      id: playlist.id,
      name: playlist.name,
      cover: playlist.cover
    }
  end
end
