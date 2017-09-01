defmodule SoundPlace.Repo.Migrations.CreateAccountsSpotifyCredentials do
  use Ecto.Migration

  def change do
    create table(:accounts_spotify_credentials) do
      add :spotify_id, :string
      add :access_token, :text
      add :refresh_token, :text
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:accounts_spotify_credentials, [:spotify_id])
    create index(:accounts_spotify_credentials, [:user_id])
  end
end
