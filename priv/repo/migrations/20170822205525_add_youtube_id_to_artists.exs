defmodule SoundPlace.Repo.Migrations.AddYoutubeIdToArtists do
  use Ecto.Migration

  def change do
    alter table(:artists) do
      add :youtube_id, :string
    end
  end
end
