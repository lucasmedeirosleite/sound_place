defmodule SoundPlace.Repo.Migrations.CreateSongsGenres do
  use Ecto.Migration

  def change do
    create table(:songs_genres, primary_key: false) do
      add :song_id, references(:songs)
      add :genre_id, references(:genres)
    end
  end
end
