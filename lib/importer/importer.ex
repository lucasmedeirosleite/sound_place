defmodule SoundPlace.Importer do
  alias SoundPlace.Importer.SpotifyImporter

  def import_playlists(user, data), do: SpotifyImporter.import_playlists(user, data)
end