defmodule SoundPlace.Repo.Migrations.CreateArtistsAlbums do
  use Ecto.Migration

  def change do
    create table(:artists_albums, primary_key: false) do
      add :artist_id, references(:artists, on_delete: :delete_all), null: false
      add :album_id, references(:albums)
    end

    create unique_index(:artists_albums, [:artist_id, :album_id])
  end
end
