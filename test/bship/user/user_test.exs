defmodule Bship.UserTest do
  use Bship.DataCase

  alias Bship.User

  describe "users" do
    alias Bship.User.UserInfo

    @valid_attrs %{account: "some@account.com", nick: "some nick", pwd_hash: "some pwd_hash", pwd: "123456"}
    @update_attrs %{account: "some@updated.com", nick: "some updated nick", pwd_hash: "some updated pwd_hash", pwd: "123456"}
    @invalid_attrs %{account: nil, nick: nil, pwd_hash: nil}

    def user_info_fixture(attrs \\ %{}) do
      {:ok, user_info} =
        attrs
        |> Enum.into(@valid_attrs)
        |> User.create_user_info()

      user_info |> Map.put(:pwd,nil)
    end

    test "list_users/0 returns all users" do
      user_info = user_info_fixture()
      assert User.list_users() == [user_info]
    end

    test "get_user_info!/1 returns the user_info with given id" do
      user_info = user_info_fixture()
      assert User.get_user_info!(user_info.id) == user_info
    end

    test "create_user_info/1 with valid data creates a user_info" do
      assert {:ok, %UserInfo{} = user_info} = User.create_user_info(@valid_attrs)
      assert user_info.account == "some@account.com"
      assert user_info.nick == "some nick"
      assert is_binary(user_info.pwd_hash) == true
    end

    test "create_user_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_user_info(@invalid_attrs)
    end

    test "update_user_info/2 with valid data updates the user_info" do
      user_info = user_info_fixture()
      assert {:ok, user_info} = User.update_user_info(user_info, @update_attrs)
      assert %UserInfo{} = user_info
      assert user_info.account == "some@updated.com"
      assert user_info.nick == "some updated nick"
      assert is_binary(user_info.pwd_hash) == true
    end

    test "update_user_info/2 with invalid data returns error changeset" do
      user_info = user_info_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_user_info(user_info, @invalid_attrs)
      assert user_info == User.get_user_info!(user_info.id)
    end

    test "delete_user_info/1 deletes the user_info" do
      user_info = user_info_fixture()
      assert {:ok, %UserInfo{}} = User.delete_user_info(user_info)
      assert_raise Ecto.NoResultsError, fn -> User.get_user_info!(user_info.id) end
    end

    test "change_user_info/1 returns a user_info changeset" do
      user_info = user_info_fixture()
      assert %Ecto.Changeset{} = User.change_user_info(user_info)
    end
  end
end
