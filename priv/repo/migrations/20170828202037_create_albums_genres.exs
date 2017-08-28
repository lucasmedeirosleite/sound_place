defmodule SoundPlace.Repo.Migrations.CreateAlbumsGenres do
  use Ecto.Migration

  def change do
    create table(:albums_genres, primary_key: false) do
      add :album_id, references(:albums)
      add :genre_id, references(:genres)
    end
  end
end
