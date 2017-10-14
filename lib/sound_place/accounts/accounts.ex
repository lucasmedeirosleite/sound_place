defmodule SoundPlace.Accounts do
  import Ecto.Query, warn: false
  alias Ecto.Changeset

  alias SoundPlace.Repo
  alias SoundPlace.Accounts.{User, SpotifyCredential, SoundPlaceCredential}

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
    |> Repo.preload(:spotify_credential)
  end

  def get_user_by(spotify_id: spotify_id) do
    query = from user in User,
            inner_join: credential in assoc(user, :spotify_credential),
            where: credential.spotify_id == ^spotify_id,
            preload: [:spotify_credential]

    Repo.one(query)
  end

  def save_user(user_params \\ %{}) do
    case get_user_by(spotify_id: user_params["spotify_credential"]["spotify_id"]) do
      nil ->
        create_user(user_params)
      user ->
        update_user(user, user_params)
    end
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:spotify_credential, with: &SpotifyCredential.changeset/2)
    |> Changeset.cast_assoc(:sound_place_credential, with: &SoundPlaceCredential.changeset/2)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Changeset.cast_assoc(:spotify_credential, with: &SpotifyCredential.changeset/2)
    |> Changeset.cast_assoc(:sound_place_credential, with: &SoundPlaceCredential.changeset/2)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_credentials(user_id: user_id) do
    query = from credential in SpotifyCredential,
            where: credential.user_id == ^user_id
    
    Repo.one(query)        
  end

  def get_credentials(spotify_id: spotify_id) do
    query = from credential in SpotifyCredential,
            where: credential.spotify_id == ^spotify_id
    
    Repo.one(query)        
  end

  def update_credential(%SpotifyCredential{} = credential, attrs, _provider \\ :spotify) do
    credential
    |> SpotifyCredential.changeset(attrs)
    |> Repo.update()
  end
end
