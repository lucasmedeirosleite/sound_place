defmodule SoundPlace.Repo.Migrations.CreateAlbumTypes do
  use Ecto.Migration

  def change do
    create table(:album_types) do
      add :name, :string

      timestamps()
    end

    create unique_index(:album_types, [:name])
  end
end
