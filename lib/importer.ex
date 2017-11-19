defmodule SoundPlace.Importer do
  alias SoundPlace.Accounts
  alias SoundPlace.Media
  alias SoundPlace.Provider
  alias SoundPlace.Transformer

  def import_tracks(playlist, tracks) do
    credentials = Accounts.get_credentials(user_id: playlist.user.id)

    tracks = tracks |> Enum.map(fn(tm) -> import_track(tm, credentials) end)

    tracks_ids = Enum.map(tracks, &(&1.id))

    SoundPlace.Library.update_playlist(playlist, %{tracks: tracks_ids})

    playlist = SoundPlace.Library.get_playlist(spotify_id: playlist.spotify_id)

    {:ok, playlist.tracks}
  end

  def import_track(tm, credentials) do
    artists = 
        tm.artists
        |> Enum.map(&(&1.spotify_id))
        |> Enum.uniq   
    
    artists = import_artists(credentials, artists) |> List.flatten
      
    artists_ids = Enum.map(artists, &(&1.id))

    genres_ids = artists |> Enum.map(&(&1.genres)) |> List.flatten |> Enum.map(&(&1.id)) |> Enum.uniq
      
    album = import_album(credentials, tm.album.spotify_id, artists_ids, genres_ids) |>List.first 

    case Media.get_track(spotify_id: tm.song.spotify_id) do
      nil ->
        song = Map.put(tm.song, :genres, genres_ids)
        tm = %{tm | song: song}

        tm 
        |> Map.delete(:album) 
        |> Map.delete(:artists)
        |> Map.put(:album_id, album.id)
        |> Media.save_track 
        |> elem(1)      
      track -> track        
    end
  end

  def import_artists(credentials, artists) do
    Enum.map(artists, fn(artist) -> import_artist(artist, credentials) end)
  end

  def import_artist(artist, credentials) do
    case Media.get_artist(spotify_id: artist) do
      nil ->
        with {:ok, artists_map} <- Provider.artists(credentials, [artist]),
              artists_map <- Transformer.transform_artists(artists_map) do
        
          Enum.map(artists_map, fn(am) ->
            genres = am.genres |> import_genres |> Enum.map(&(&1.id))
            %{am | genres: genres}
            |> Media.save_artist
            |> elem(1)
          end)
        end
      artist -> [artist]
    end
  end

  def import_genres(genres) do 
    {:ok, genres} = Media.save_genres(genres)
    genres
  end

  def import_album(credentials, album, artists_ids, genres_ids) do
    case Media.get_album(spotify_id: album) do
      nil ->
        with {:ok, albums_map} <- Provider.albums(credentials, [album]),
             albums_map <- Transformer.transform_albums(albums_map) do

          Enum.map(albums_map, fn(al) ->
            {:ok, label} = al.label |> Media.save_label
            {:ok, album_type} = al.album_type |> Media.save_album_type

            al
            |> Map.delete(:label)
            |> Map.delete(:album_type)
            |> Map.put(:label_id, label.id)
            |> Map.put(:album_type_id, album_type.id)
            |> Map.put(:artists, artists_ids)
            |> Map.put(:genres, genres_ids)
            |> Media.save_album
            |> elem(1)
          end)
        end
      album -> [album]
    end
  end
end