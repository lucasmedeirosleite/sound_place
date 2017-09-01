defmodule SoundPlace.Accounts.SpotifyCredential do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Accounts.{User, SpotifyCredential}

  schema "accounts_spotify_credentials" do
    field :access_token, :string
    field :refresh_token, :string
    field :spotify_id, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%SpotifyCredential{} = spotify_credential, attrs) do
    spotify_credential
    |> cast(attrs, [:spotify_id, :access_token, :refresh_token])
    |> validate_required([:spotify_id, :access_token, :refresh_token])
    |> unique_constraint(:spotify_id)
  end
end
