defmodule Bship.PlayerTest do
  use Bship.DataCase

  alias Bship.Player

  describe "attrs" do
    alias Bship.Player.Attr

    @valid_attrs %{score: 42}
    @update_attrs %{score: 43}
    @invalid_attrs %{score: nil}

    def attr_fixture(attrs \\ %{}) do
      {:ok, attr} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Player.create_attr()

      attr
    end

    test "list_attrs/0 returns all attrs" do
      attr = attr_fixture()
      assert Player.list_attrs() == [attr]
    end

    test "get_attr!/1 returns the attr with given id" do
      attr = attr_fixture()
      assert Player.get_attr!(attr.id) == attr
    end

    test "create_attr/1 with valid data creates a attr" do
      assert {:ok, %Attr{} = attr} = Player.create_attr(@valid_attrs)
      assert attr.score == 42
    end

    test "create_attr/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Player.create_attr(@invalid_attrs)
    end

    test "update_attr/2 with valid data updates the attr" do
      attr = attr_fixture()
      assert {:ok, attr} = Player.update_attr(attr, @update_attrs)
      assert %Attr{} = attr
      assert attr.score == 43
    end

    test "update_attr/2 with invalid data returns error changeset" do
      attr = attr_fixture()
      assert {:error, %Ecto.Changeset{}} = Player.update_attr(attr, @invalid_attrs)
      assert attr == Player.get_attr!(attr.id)
    end

    test "delete_attr/1 deletes the attr" do
      attr = attr_fixture()
      assert {:ok, %Attr{}} = Player.delete_attr(attr)
      assert_raise Ecto.NoResultsError, fn -> Player.get_attr!(attr.id) end
    end

    test "change_attr/1 returns a attr changeset" do
      attr = attr_fixture()
      assert %Ecto.Changeset{} = Player.change_attr(attr)
    end
  end
end
