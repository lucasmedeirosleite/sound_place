defmodule SoundPlace.Repo.Migrations.CreateLibraryPlaylists do
  use Ecto.Migration

  def change do
    create table(:library_playlists) do
      add :spotify_id, :string
      add :name, :string
      add :cover, :text
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:library_playlists, [:spotify_id])
    create index(:library_playlists, [:user_id])
  end
end
