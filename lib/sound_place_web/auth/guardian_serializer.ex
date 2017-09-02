defmodule SoundPlaceWeb.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias SoundPlace.Admin
  alias SoundPlace.Accounts

  def for_token(user = %Admin.User{}), do: { :ok, "AdminUser:#{user.id}" }
  def for_token(user = %Accounts.User{}), do: { :ok, "AccountsUser:#{user.id}"}
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("AdminUser:" <> id), do: { :ok, Admin.get_user!(id) }
  def from_token("AccountsUser:" <> id), do: {:ok, Accounts.get_user!(id) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
