defmodule SoundPlace.Library do
  import Ecto.Query, warn: false

  alias SoundPlace.Repo
  alias SoundPlace.Library.{Artist, Playlist}
  alias SoundPlace.Media.Track

  def list_playlists do
    Repo.all(Playlist)
  end

  def list_playlists(user_id: user_id) do
    query = from playlist in Playlist,
            where: playlist.user_id == ^user_id
    
    Repo.all(query)
  end

  def get_playlist!(id) do
    Playlist
    |> Repo.get!(id)
    |> Repo.preload(:tracks)
  end

  def get_playlist(spotify_id: spotify_id) do
    query = from playlist in Playlist,
            where: playlist.spotify_id == ^spotify_id,
            preload: [:user, [tracks: [[album: :artists], :song]]]
    
    Repo.one(query)
  end

  def save_playlists(playlists \\ []) do
    Repo.transaction(fn ->
      playlists
      |> Enum.map(&save_playlist/1)  
      |> Enum.map(fn({:ok, playlist}) -> playlist end)
    end) 
  end

  def save_playlist(attrs \\ %{}) do
    case get_playlist(spotify_id: attrs.spotify_id) do
      nil -> create_playlist(attrs)
      playlist -> update_playlist(playlist, attrs)
    end
  end

  def create_playlist(attrs \\ %{}) do
    %Playlist{}
    |> Playlist.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:tracks, Repo, Track)
    |> Repo.insert()
  end

  def update_playlist(%Playlist{} = playlist, attrs) do
    playlist
    |> Playlist.changeset(attrs)
    |> PhoenixMTM.Changeset.cast_collection(:tracks, Repo, Track)
    |> Repo.update()
  end

  def delete_playlist(%Playlist{} = playlist) do
    Repo.delete(playlist)
  end

  def change_playlist(%Playlist{} = playlist) do
    Playlist.changeset(playlist, %{})
  end

  def list_artists(user_id: user_id) do
    query = from artist in Artist,
            where: artist.user_id == ^user_id
    
    Repo.all(query)
  end
end
