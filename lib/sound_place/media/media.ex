defmodule SoundPlace.Media do
  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias SoundPlace.Repo
  alias SoundPlace.Media.{Genre, Label, AlbumType, Artist, Album, Track, Song}

  # Genres

  def list_genres do
    Repo.all(Genre)
  end

  def get_genre!(id), do: Repo.get!(Genre, id)
  
  def get_genre(name: name) do
    query = from genre in Genre,
            where: genre.name == ^name
    
    Repo.one(query)
  end

  def save_genres(genres \\ []) do
    Repo.transaction(fn ->
      genres
      |> Enum.map(&save_genre/1)  
      |> Enum.map(&(elem(&1, 1)))
    end)
  end

  def save_genre(attrs \\ %{}) do
    case get_genre(name: attrs.name) do
      nil -> create_genre(attrs)
      genre -> update_genre(genre, attrs)
    end
  end

  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  def change_genre(%Genre{} = genre) do
    Genre.changeset(genre, %{})
  end

  # Labels

  def list_labels do
    Repo.all(Label)
  end

  def get_label!(id), do: Repo.get!(Label, id)

  def get_label(name: name) do
    query = from label in Label,
            where: label.name == ^name
    
    Repo.one(query)
  end

  def save_label(attrs \\ %{}) do
    case get_label(name: attrs.name) do
      nil -> create_label(attrs)
      label -> update_label(label, attrs)
    end
  end

  def create_label(attrs \\ %{}) do
    %Label{}
    |> Label.changeset(attrs)
    |> Repo.insert()
  end

  def update_label(%Label{} = label, attrs) do
    label
    |> Label.changeset(attrs)
    |> Repo.update()
  end

  def delete_label(%Label{} = label) do
    Repo.delete(label)
  end

  def change_label(%Label{} = label, attrs \\ %{}) do
    Label.changeset(label, attrs)
  end

  # Album types

  def list_album_types do
    Repo.all(AlbumType)
  end

  def get_album_type!(id), do: Repo.get!(AlbumType, id)

  def get_album_type(name: name) do
    query = from album_type in AlbumType,
            where: album_type.name == ^name
    
    Repo.one(query)
  end

  def save_album_type(attrs \\ %{}) do
    case get_album_type(name: attrs.name) do
      nil -> create_album_type(attrs)
      album_type -> update_album_type(album_type, attrs)
    end
  end

  def create_album_type(attrs \\ %{}) do
    %AlbumType{}
    |> AlbumType.changeset(attrs)
    |> Repo.insert()
  end

  def update_album_type(%AlbumType{} = album_type, attrs) do
    album_type
    |> AlbumType.changeset(attrs)
    |> Repo.update()
  end

  def delete_album_type(%AlbumType{} = album_type) do
    Repo.delete(album_type)
  end

  def change_album_type(%AlbumType{} = album_type, attrs \\ %{}) do
    AlbumType.changeset(album_type, attrs)
  end

  # Artists

  def list_artists do
    Repo.all(Artist)
  end

  def get_artist!(id) do
    Artist
    |> Repo.get!(id)
    |> Repo.preload(:genres)
  end

  def get_artist(spotify_id: spotify_id) do
    query = from artist in Artist,
            where: artist.spotify_id == ^spotify_id,
            preload: [:genres]
    
    Repo.one(query)
  end

  def save_artist(attrs \\ %{}) do
    case get_artist(spotify_id: attrs.spotify_id) do
      nil -> create_artist(attrs)
      artist -> update_artist(artist, attrs)
    end
  end

  def create_artist(attrs \\ %{}) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:genres, Repo, Genre)
    |> Repo.insert()
  end

  def update_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:genres, Repo, Genre)
    |> Repo.update()
  end

  def delete_artist(%Artist{} = artist) do
    Repo.delete(artist)
  end

  def change_artist(%Artist{} = artist) do
    Artist.changeset(artist, %{})
  end

  # Albums

  def list_albums do
    Album
    |> Repo.all()
    |> Repo.preload(:artists)
  end

  def list_albums(artist_id: artist_id) do
    query = from album in Album,
            inner_join: artist in assoc(album, :artists),
            where: artist.id == ^artist_id,
            preload: [:label, :album_type]

    Repo.all(query)
  end

  def get_album!(id) do
    Album
    |> Repo.get!(id)
    |> Repo.preload([:artists, :genres, :label, :album_type])
  end

  def get_album(spotify_id: spotify_id) do
    query = from album in Album,
            where: album.spotify_id == ^spotify_id,
            preload: [:label, :album_type, :artists, :genres]
    
    Repo.one(query)
  end

  def save_album(attrs \\ %{}) do
    case get_album(spotify_id: attrs.spotify_id) do
      nil -> create_album(attrs)
      album -> update_album(album, attrs)
    end
  end

  def create_album(attrs \\ %{}) do
    %Album{}
    |> Album.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:artists, Repo, Artist)
    |> PhoenixMTM.Changeset.cast_collection(:genres, Repo, Genre)
    |> Repo.insert()
  end

  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:artists, Repo, Artist)
    |> PhoenixMTM.Changeset.cast_collection(:genres, Repo, Genre)
    |> Repo.update()
  end

  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  def change_album(%Album{} = album) do
    Album.changeset(album, %{})
  end

  # Tracks

  def list_tracks(album_id: album_id) do
    query = from track in Track,
            inner_join: album in assoc(track, :album),
            where: album.id == ^album_id,
            preload: [:song]

    Repo.all(query)
  end

  def get_track!(id) do
    Track
    |> Repo.get!(id)
    |> Repo.preload([song: :genres])
  end

  def get_track(spotify_id: spotify_id) do
    query = from track in Track,
            inner_join: song in assoc(track, :song),
            where: song.spotify_id == ^spotify_id,
            preload: [:song, album: :artists]

    Repo.one(query)
  end

  def save_track(attrs \\ %{}) do
    case get_track(spotify_id: attrs.song.spotify_id) do
      nil -> create_track(attrs)
      track -> update_track(track, attrs)
    end
  end

  def create_track(attrs \\ %{}) do
    %Track{}
    |> Track.changeset(attrs)
    |> Changeset.cast_assoc(:song, with: &SoundPlace.Media.change_song/2)
    |> Repo.insert()
  end

  def update_track(%Track{} = track, attrs) do
    track
    |> Track.changeset(attrs)
    |> Changeset.cast_assoc(:song, with: &SoundPlace.Media.change_song/2)
    |> Repo.update()
  end

  def delete_track(%Track{} = track) do
    Repo.transaction(fn ->
      Repo.delete(track)
      Repo.delete(track.song)
    end)
  end

  def change_track(%Track{} = track) do
    Track.changeset(track, %{})
  end

  def change_song(%Song{} = song, attrs) do
    song
    |> Song.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:genres, Repo, Genre)
  end
end
