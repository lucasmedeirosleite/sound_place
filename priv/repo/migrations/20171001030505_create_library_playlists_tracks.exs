defmodule SoundPlace.Repo.Migrations.CreateLibraryPlaylistsTracks do
  use Ecto.Migration

  def change do
    create table(:library_playlists_tracks, primary_key: false) do
      add :playlist_id, references(:library_playlists, on_delete: :delete_all), null: false
      add :track_id, references(:tracks)
    end

    create unique_index(:library_playlists_tracks, [:playlist_id, :track_id])
  end
end
