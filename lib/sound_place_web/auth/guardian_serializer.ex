defmodule SoundPlaceWeb.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias SoundPlace.Admin
  alias SoundPlace.Admin.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Admin.get_user!(id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
