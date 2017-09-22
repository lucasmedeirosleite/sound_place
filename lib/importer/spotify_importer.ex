defmodule SoundPlace.Importer.SpotifyImporter do
  alias SoundPlace.Extensions.Parallel

  def import_playlists(user, %{items: data}) do
    data
    |> Parallel.pmap(&transform(user, &1)) 
    |> SoundPlace.Library.save_playlists
  end

  defp transform(user, playlist) do
    cover = List.first(playlist.images)["url"]
    %{name: playlist.name, spotify_id: playlist.id, cover: cover, user_id: user.id}
  end
end