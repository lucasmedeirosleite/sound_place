defmodule SoundPlace.Admin do
  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias SoundPlace.Repo
  alias SoundPlace.Admin.{User, Credential}

  def list_users do
    User
    |> Repo.all()
    |> Repo.preload(:credential)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:credential)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:credential, with: &Credential.changeset/2)
    |> Repo.insert()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
