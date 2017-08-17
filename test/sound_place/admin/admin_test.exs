defmodule SoundPlace.AdminTest do
  use SoundPlace.DataCase

  alias SoundPlace.Admin

  describe "users" do
    alias SoundPlace.Admin.User

    @credential_attrs %{email: "email@example.com", password: "123456"}
    @valid_attrs %{name: "some name", username: "some username", credential: @credential_attrs}
    @invalid_attrs %{name: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user_fixture()

      assert Enum.count(Admin.list_users()) > 0
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()

      retrieved_user = Admin.get_user!(user.id)

      assert  retrieved_user.id == user.id
      assert  retrieved_user.name == user.name
      assert  retrieved_user.username == user.username
      assert  retrieved_user.credential.email == user.credential.email
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Admin.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_user(@invalid_attrs)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admin.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admin.change_user(user)
    end
  end
end
