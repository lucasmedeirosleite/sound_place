defmodule SoundPlace.Transformer.SpotifyTransformer do
  alias SoundPlace.Extensions.Parallel

  def transform_playlists(data, user_id), do: Parallel.pmap(data, &transform_playlist(user_id, &1)) 

  defp transform_playlist(user_id, playlist) do
    %{}
    |> Map.put(:name, playlist.name)
    |> Map.put(:spotify_id, playlist.id)
    |> Map.put(:cover, transform_images(playlist.images))
    |> Map.put(:user_id, user_id)
  end

  def transform_tracks(playlist, data), do: {playlist, Parallel.pmap(data, &transform_track/1) }

  defp transform_track(%{"track": track_map}) do
    %{}
    |> Map.put(:sequence, track_map.track_number)
    |> Map.put(:album, transform_album(track_map.album))
    |> Map.put(:artists, transform_artists(track_map.artists))
    |> Map.put(:song, transform_song(track_map))
  end

  defp transform_song(track_map) do
    %{}
    |> Map.put(:spotify_id, track_map.id)
    |> Map.put(:name, track_map.name)
    |> Map.put(:duration, track_map.duration_ms)
    |> Map.put(:explicit, track_map.explicit)
  end

  def transform_albums(data), do: Parallel.pmap(data, &transform_album/1)

  defp transform_album(%{"id" => album_id}), do: %{spotify_id: album_id}

  defp transform_album(album_map) do
    %{}
    |> Map.put(:spotify_id, album_map.id)
    |> Map.put(:name, album_map.name)
    |> Map.put(:cover, transform_images(album_map.images))
    |> Map.put(:release_year, transform_release_date(album_map.release_date))
    |> Map.put(:label, transform_label(album_map.label))
    |> Map.put(:album_type, transform_album_type(album_map.album_type))
    |> Map.put(:artists, Enum.map(album_map.artists, &transform_artist/1))
    |> Map.put(:genres, Enum.map(album_map.genres, &transform_genre/1))
  end

  defp transform_release_date(release_date) do
    release_date
    |> String.slice(0..3)
    |> String.to_integer
  end

  defp transform_label(label) do
    %{name: label}
  end

  defp transform_album_type(album_type) do
    %{name: album_type}
  end

  def transform_artists(data), do: Parallel.pmap(data, &transform_artist/1)

  defp transform_artist(%{"id" => artist_id}), do: %{spotify_id: artist_id}

  defp transform_artist(artist_map) do
    %{}
    |> Map.put(:spotify_id, artist_map.id)
    |> Map.put(:name, artist_map.name)
    |> Map.put(:image, transform_images(artist_map.images))
    |> Map.put(:genres, Enum.map(artist_map.genres, &transform_genre/1))
  end

  defp transform_genre(genre) do
    %{name: genre}
  end

  defp transform_images(images) do
    case Enum.fetch(images, 0) do
      {:ok, image} ->
        image["url"]
      :error ->
        nil
    end
  end
end