defmodule SoundPlace.Importer.SpotifyImporter do
  def import_playlists(user, %{items: data}) do
    {:ok, playlists} = 
    Enum.map(data, &transform(user, &1)) 
    |> SoundPlace.Library.create_playlists
    
    {:ok, Enum.map(playlists, fn({:ok, playlist}) -> playlist end)}
  end

  defp transform(user, playlist) do
    cover = List.first(playlist.images)["url"]
    %{name: playlist.name, spotify_id: playlist.id, cover: cover, user_id: user.id}
  end
end