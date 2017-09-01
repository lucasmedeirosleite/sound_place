defmodule SoundPlace.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :name, :string
      add :email, :string
      add :image, :text

      timestamps()
    end

    create unique_index(:accounts_users, [:email])
  end
end
