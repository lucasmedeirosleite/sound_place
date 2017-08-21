defmodule SoundPlace.Repo.Migrations.AddAcronymToAlbumTypes do
  use Ecto.Migration

  def change do
    alter table(:album_types) do
      add :acronym, :string
    end

    create unique_index(:album_types, [:acronym])
  end
end
