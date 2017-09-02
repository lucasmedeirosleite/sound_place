defmodule SoundPlace.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Accounts.{User, SpotifyCredential, SoundPlaceCredential}

  schema "accounts_users" do
    field :email, :string
    field :image, :string
    field :name, :string
    has_one :spotify_credential, SpotifyCredential, on_replace: :update
    has_one :sound_place_credential, SoundPlaceCredential, on_replace: :update

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
