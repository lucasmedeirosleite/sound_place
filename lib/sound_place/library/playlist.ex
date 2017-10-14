defmodule SoundPlace.Library.Playlist do
  use Ecto.Schema
  import Ecto.Changeset
  alias SoundPlace.Library.Playlist
  alias SoundPlace.Media.Track
  alias SoundPlace.Accounts.User


  schema "library_playlists" do
    field :cover, :string
    field :name, :string
    field :spotify_id, :string
    belongs_to :user, User
    many_to_many :tracks, Track, join_through: "library_playlists_tracks", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(%Playlist{} = playlist, attrs) do
    playlist
    |> cast(attrs, [:spotify_id, :name, :cover, :user_id])
    |> validate_required([:spotify_id, :name])
    |> unique_constraint(:spotify_id)
  end
end
