defmodule SoundPlace.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Accounts.User

  schema "accounts_users" do
    field :email, :string
    field :image, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :image])
    |> validate_required([:name, :email, :image])
    |> unique_constraint(:email)
  end
end
