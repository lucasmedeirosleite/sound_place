defmodule SoundPlace.Transformer do
  alias SoundPlace.Transformer.SpotifyTransformer

  def transform_albums(data), do: SpotifyTransformer.transform_albums(data)

  def transform_artists(data), do: SpotifyTransformer.transform_artists(data)

  def transform_playlists(data, user_id), do: SpotifyTransformer.transform_playlists(data, user_id)

  def transform_tracks(playlist, data), do: SpotifyTransformer.transform_tracks(playlist, data)
end