defmodule SoundPlace.Media.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.{Song, Genre}

  schema "songs" do
    field :duration, :integer
    field :explicit, :boolean, default: false
    field :name, :string
    field :spotify_id, :string
    field :video_id, :string
    many_to_many :genres, Genre, join_through: "songs_genres", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Song{} = song, attrs) do
    song
    |> cast(attrs, [:name, :spotify_id, :duration, :explicit, :video_id])
    |> validate_required([:name, :spotify_id, :duration])
    |> unique_constraint(:spotify_id)
  end
end
