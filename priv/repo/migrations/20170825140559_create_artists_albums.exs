defmodule SoundPlace.Repo.Migrations.CreateArtistsAlbums do
  use Ecto.Migration

  def change do
    create table(:artists_albums, primary_key: false) do
      add :artist_id, references(:artists)
      add :album_id, references(:albums)
    end
  end
end
