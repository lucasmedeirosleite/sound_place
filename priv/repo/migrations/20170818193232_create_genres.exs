defmodule SoundPlace.Repo.Migrations.CreateGenres do
  use Ecto.Migration

  def change do
    create table(:genres) do
      add :name, :string

      timestamps()
    end

    create unique_index(:genres, [:name])
  end
end
