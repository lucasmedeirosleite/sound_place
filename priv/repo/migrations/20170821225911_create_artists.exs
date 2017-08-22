defmodule SoundPlace.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string
      add :website, :string
      add :facebook, :string
      add :instagram, :string
      add :twitter, :string
      add :spotify_id, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:artists, [:name])
    create unique_index(:artists, [:spotify_id])
  end
end
