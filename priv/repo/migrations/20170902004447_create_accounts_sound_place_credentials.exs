defmodule SoundPlace.Repo.Migrations.CreateAccountsSoundPlaceCredentials do
  use Ecto.Migration

  def change do
    create table(:accounts_sound_place_credentials) do
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:accounts_sound_place_credentials, [:user_id])
  end
end
