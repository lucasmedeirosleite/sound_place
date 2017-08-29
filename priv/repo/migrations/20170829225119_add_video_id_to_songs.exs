defmodule SoundPlace.Repo.Migrations.AddVideoIdToSongs do
  use Ecto.Migration

  def change do
    alter table(:songs) do
      add :video_id, :string
    end
  end
end
