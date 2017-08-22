defmodule SoundPlace.Media.Artist do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.Artist

  schema "artists" do
    field :facebook, :string
    field :image, :string
    field :instagram, :string
    field :name, :string
    field :spotify_id, :string
    field :twitter, :string
    field :website, :string
    field :youtube_id, :string

    timestamps()
  end

  @doc false
  def changeset(%Artist{} = artist, attrs) do
    artist
    |> cast(attrs, [:name, :website, :facebook, :instagram, :twitter, :spotify_id, :image, :youtube_id])
    |> validate_required([:name, :spotify_id, :image])
    |> unique_constraint(:name)
    |> unique_constraint(:spotify_id)
  end
end