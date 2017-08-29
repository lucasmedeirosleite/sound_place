defmodule SoundPlace.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :sequence, :integer
      add :album_id, references(:albums, on_delete: :nothing), null: false
      add :song_id, references(:songs, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:tracks, [:album_id])
    create index(:tracks, [:song_id])
    create unique_index(:tracks, [:album_id, :song_id])
  end
end
