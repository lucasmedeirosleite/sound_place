defmodule SoundPlace.Media.Genre do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.Genre

  schema "genres" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Genre{} = genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
