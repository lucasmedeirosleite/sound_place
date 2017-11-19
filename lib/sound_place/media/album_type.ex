defmodule SoundPlace.Media.AlbumType do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.AlbumType

  schema "album_types" do
    field :name, :string
    field :acronym, :string

    timestamps()
  end

  @doc false
  def changeset(%AlbumType{} = album_type, attrs) do
    album_type
    |> cast(attrs, [:name, :acronym])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
