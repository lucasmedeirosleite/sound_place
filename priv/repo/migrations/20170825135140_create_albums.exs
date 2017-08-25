defmodule SoundPlace.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :spotify_id, :string
      add :release_year, :integer
      add :cover, :string
      add :label_id, references(:labels, on_delete: :nothing)
      add :album_type_id, references(:album_types, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:albums, [:spotify_id])
    create index(:albums, [:label_id])
    create index(:albums, [:album_type_id])
  end
end
