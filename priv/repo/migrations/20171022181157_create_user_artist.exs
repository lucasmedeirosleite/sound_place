defmodule SoundPlace.Repo.Migrations.CreateUserArtist do
  use Ecto.Migration

  def change do
    create table(:library_artists) do
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false
      add :artist_id, references(:artists, on_delete: :delete_all), null: false
      timestamps()
    end

    create unique_index(:library_artists, [:user_id, :artist_id])
  end
end
