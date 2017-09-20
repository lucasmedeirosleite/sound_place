defmodule SoundPlace.Library do
  import Ecto.Query, warn: false
  # alias Ecto.Changeset

  alias SoundPlace.Repo
  alias SoundPlace.Library.Playlist

  def list_playlists do
    Repo.all(Playlist)
  end

  def list_playlists(user_id) do
    query = from playlist in Playlist,
            where: playlist.user_id == ^user_id
    
    Repo.all(query)
  end

  def get_playlist!(id), do: Repo.get!(Playlist, id)

  def create_playlists(playlists \\ []) do
    Repo.transaction(fn ->
      Enum.map(playlists, &create_playlist/1)
    end)
  end

  def create_playlist(attrs \\ %{}) do
    %Playlist{}
    |> Playlist.changeset(attrs)
    |> Repo.insert()
  end

  def update_playlist(%Playlist{} = playlist, attrs) do
    playlist
    |> Playlist.changeset(attrs)
    |> Repo.update()
  end

  def delete_playlist(%Playlist{} = playlist) do
    Repo.delete(playlist)
  end

  def change_playlist(%Playlist{} = playlist) do
    Playlist.changeset(playlist, %{})
  end
end
