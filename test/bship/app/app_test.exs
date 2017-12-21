defmodule Bship.AppTest do
  use Bship.DataCase

  alias Bship.App

  describe "apps" do
    alias Bship.App.AppInfo

    @valid_attrs %{eq: 42, gt: 42, lt: 42, name: "some name"}
    @update_attrs %{eq: 43, gt: 43, lt: 43, name: "some updated name"}
    @invalid_attrs %{eq: nil, gt: nil, lt: nil, name: nil}

    def app_info_fixture(attrs \\ %{}) do
      {:ok, app_info} =
        attrs
        |> Enum.into(@valid_attrs)
        |> App.create_app_info()

      app_info
    end

    test "list_apps/0 returns all apps" do
      app_info = app_info_fixture()
      assert App.list_apps() == [app_info]
    end

    test "get_app_info!/1 returns the app_info with given id" do
      app_info = app_info_fixture()
      assert App.get_app_info!(app_info.id) == app_info
    end

    test "create_app_info/1 with valid data creates a app_info" do
      assert {:ok, %AppInfo{} = app_info} = App.create_app_info(@valid_attrs)
      assert app_info.eq == 42
      assert app_info.gt == 42
      assert app_info.lt == 42
      assert app_info.name == "some name"
    end

    test "create_app_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = App.create_app_info(@invalid_attrs)
    end

    test "update_app_info/2 with valid data updates the app_info" do
      app_info = app_info_fixture()
      assert {:ok, app_info} = App.update_app_info(app_info, @update_attrs)
      assert %AppInfo{} = app_info
      assert app_info.eq == 43
      assert app_info.gt == 43
      assert app_info.lt == 43
      assert app_info.name == "some updated name"
    end

    test "update_app_info/2 with invalid data returns error changeset" do
      app_info = app_info_fixture()
      assert {:error, %Ecto.Changeset{}} = App.update_app_info(app_info, @invalid_attrs)
      assert app_info == App.get_app_info!(app_info.id)
    end

    test "delete_app_info/1 deletes the app_info" do
      app_info = app_info_fixture()
      assert {:ok, %AppInfo{}} = App.delete_app_info(app_info)
      assert_raise Ecto.NoResultsError, fn -> App.get_app_info!(app_info.id) end
    end

    test "change_app_info/1 returns a app_info changeset" do
      app_info = app_info_fixture()
      assert %Ecto.Changeset{} = App.change_app_info(app_info)
    end
  end
end
