defmodule BshipWeb.AppInfoControllerTest do
  use BshipWeb.ConnCase

  alias Bship.App

  @create_attrs %{eq: 42, gt: 42, lt: 42, name: "some name"}
  @update_attrs %{eq: 43, gt: 43, lt: 43, name: "some updated name"}
  @invalid_attrs %{eq: nil, gt: nil, lt: nil, name: nil}

  def fixture(:app_info) do
    {:ok, app_info} = App.create_app_info(@create_attrs)
    app_info
  end

  describe "index" do
    test "lists all apps", %{conn: conn} do
      conn = get conn, app_info_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Apps"
    end
  end

  describe "new app_info" do
    test "renders form", %{conn: conn} do
      conn = get conn, app_info_path(conn, :new)
      assert html_response(conn, 200) =~ "New App info"
    end
  end

  describe "create app_info" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, app_info_path(conn, :create), app_info: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == app_info_path(conn, :show, id)

      conn = get conn, app_info_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show App info"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, app_info_path(conn, :create), app_info: @invalid_attrs
      assert html_response(conn, 200) =~ "New App info"
    end
  end

  describe "edit app_info" do
    setup [:create_app_info]

    test "renders form for editing chosen app_info", %{conn: conn, app_info: app_info} do
      conn = get conn, app_info_path(conn, :edit, app_info)
      assert html_response(conn, 200) =~ "Edit App info"
    end
  end

  describe "update app_info" do
    setup [:create_app_info]

    test "redirects when data is valid", %{conn: conn, app_info: app_info} do
      conn = put conn, app_info_path(conn, :update, app_info), app_info: @update_attrs
      assert redirected_to(conn) == app_info_path(conn, :show, app_info)

      conn = get conn, app_info_path(conn, :show, app_info)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, app_info: app_info} do
      conn = put conn, app_info_path(conn, :update, app_info), app_info: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit App info"
    end
  end

  describe "delete app_info" do
    setup [:create_app_info]

    test "deletes chosen app_info", %{conn: conn, app_info: app_info} do
      conn = delete conn, app_info_path(conn, :delete, app_info)
      assert redirected_to(conn) == app_info_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, app_info_path(conn, :show, app_info)
      end
    end
  end

  defp create_app_info(_) do
    app_info = fixture(:app_info)
    {:ok, app_info: app_info}
  end
end
