defmodule SoundPlace.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :name, :string
      add :spotify_id, :string
      add :duration, :integer
      add :explicit, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:songs, [:spotify_id])
  end
end
