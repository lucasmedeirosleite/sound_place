defmodule SoundPlace.Media.Album do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.{Album, Artist}


  schema "albums" do
    field :cover, :string
    field :name, :string
    field :release_year, :integer
    field :spotify_id, :string
    field :label_id, :id
    field :album_type_id, :id
    many_to_many :artists, Artist, join_through: "artists_albums", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Album{} = album, attrs) do
    album
    |> cast(attrs, [:name, :spotify_id, :release_year, :cover])
    |> validate_required([:name, :spotify_id, :release_year, :cover])
    |> unique_constraint(:spotify_id)
  end
end
