defmodule SoundPlace.Library.Artist do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Library.Artist
  alias SoundPlace.Accounts.User


  schema "library_artists" do
    belongs_to :user, User
    belongs_to :artist, SoundPlace.Media.Artist

    timestamps()
  end

  @doc false
  def changeset(%Artist{} = artist, attrs) do
    artist
    |> cast(attrs, [:user_id, :artist_id])
    |> validate_required([:user_id, :artist_id])
  end
end
