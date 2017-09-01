defmodule SoundPlace.Accounts do
  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias SoundPlace.Repo
  alias SoundPlace.Accounts.{User, SpotifyCredential}

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:spotify_credential, with: &SpotifyCredential.changeset/2)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
