defmodule SoundPlace.Media.Album do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.{Album, Artist, Label, AlbumType, Genre, Track}

  schema "albums" do
    field :cover, :string
    field :name, :string
    field :release_year, :integer
    field :spotify_id, :string
    belongs_to :label, Label
    belongs_to :album_type, AlbumType
    has_many :tracks, Track, on_delete: :delete_all
    many_to_many :genres, Genre, join_through: "albums_genres", on_delete: :delete_all, on_replace: :delete
    many_to_many :artists, Artist, join_through: "artists_albums", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Album{} = album, attrs) do
    album
    |> cast(attrs, [:name, :spotify_id, :release_year, :cover, :label_id, :album_type_id])
    |> validate_required([:name, :spotify_id, :cover])
    |> unique_constraint(:spotify_id)
  end
end
