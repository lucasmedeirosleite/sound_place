defmodule SoundPlace.Admin do
  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias Comeonin.Bcrypt

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

  def user_by(email: email) do
    query = from u in User,
            inner_join: c in assoc(u, :credential),
            where: c.email == ^email,
            preload: [:credential]

    case Repo.one(query) do
      %User{} = user -> {:ok, user}
      nil -> {:error, :not_found}
    end
  end

  def password_match?(%Credential{} = credential, password) do
    if credential && Bcrypt.checkpw(password, credential.password_hash) do
      {:ok, credential}
    else
      {:error, :does_not_match}
    end
  end

  def authenticate_by(email: email, password: password) do
    with {:ok, user} <- user_by(email: email),
         {:ok, _}    <- password_match?(user.credential, password) do
      {:ok, user}
    else {:error, _} ->
      {:error, :unauthorized}
    end
  end
end
