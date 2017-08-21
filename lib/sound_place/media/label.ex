defmodule SoundPlace.Media.Label do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Media.Label


  schema "labels" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Label{} = label, attrs) do
    label
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
