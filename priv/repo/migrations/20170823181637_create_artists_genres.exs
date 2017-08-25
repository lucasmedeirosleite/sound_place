defmodule SoundPlace.Repo.Migrations.CreateArtistsGenres do
  use Ecto.Migration

  def change do
    create table(:artists_genres, primary_key: false) do
      add :artist_id, references(:artists, on_delete: :delete_all), null: false
      add :genre_id, references(:genres)
    end

    create unique_index(:artists_genres, [:artist_id, :genre_id])
  end
end
