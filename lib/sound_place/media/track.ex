defmodule SoundPlace.Media.Track do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.{Track, Album, Song}

  schema "tracks" do
    field :sequence, :integer
    belongs_to :album, Album
    belongs_to :song, Song

    timestamps()
  end

  @doc false
  def changeset(%Track{} = track, attrs) do
    track
    |> cast(attrs, [:sequence, :album_id])
    |> validate_required([:sequence, :album_id])
  end
end
