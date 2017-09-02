defmodule SoundPlace.Accounts.SoundPlaceCredential do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Accounts.{User, SoundPlaceCredential}


  schema "accounts_sound_place_credentials" do
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%SoundPlaceCredential{} = sound_place_credential, attrs) do
    sound_place_credential
    |> cast(attrs, [])
    |> validate_required([])
  end
end
