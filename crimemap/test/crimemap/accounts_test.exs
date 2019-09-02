defmodule Crimemap.AccountsTest do
  use Crimemap.DataCase

  alias Crimemap.Accounts
  alias Crimemap.Accounts.Encryption

  describe "users" do
    alias Crimemap.Accounts.User

    @valid_attrs %{email: "some email", password: "some encrypted_password", username: "username"}
    @update_attrs %{email: "some updated email", password: "some updated encrypted_password", username: "updatedusername"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      user_from_db = Accounts.get_user!(user.id)
      assert {user_from_db.email, user_from_db.username, user_from_db.encrypted_password} == {user.email, user.username, user.encrypted_password}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert Encryption.validate_password(user, "some encrypted_password") == true
      assert user.username == "username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert Encryption.validate_password(user, "some updated encrypted_password") == true
      assert user.username == "updatedusername"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      user_from_db = Accounts.get_user!(user.id)
      assert {user_from_db.email, user_from_db.username, user_from_db.encrypted_password} == {user.email, user.username, user.encrypted_password}
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
