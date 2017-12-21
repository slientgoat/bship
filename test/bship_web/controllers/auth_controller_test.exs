defmodule BshipWeb.AuthControllerTest do
  use BshipWeb.ConnCase

  alias Bship.User

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:auth) do
    {:ok, auth} = User.create_user_info(@create_attrs)
    auth
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, auth_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new auth" do
    test "renders form", %{conn: conn} do
      conn = get conn, auth_path(conn, :new)
      assert html_response(conn, 200) =~ "New Auth"
    end
  end

  describe "create auth" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, auth_path(conn, :create), auth: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == auth_path(conn, :show, id)

      conn = get conn, page_path(conn, :index)
      assert html_response(conn, 200) =~ "Wellcome to BShip!"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, auth_path(conn, :create), auth: @invalid_attrs
      assert html_response(conn, 200) =~ "New Auth"
    end
  end

  describe "edit auth" do
    setup [:create_auth]

    test "renders form for editing chosen auth", %{conn: conn, auth: auth} do
      conn = get conn, auth_path(conn, :edit, auth)
      assert html_response(conn, 200) =~ "Edit Auth"
    end
  end

  describe "update auth" do
    setup [:create_auth]

    test "redirects when data is valid", %{conn: conn, auth: auth} do
      conn = put conn, auth_path(conn, :update, auth), auth: @update_attrs
      assert redirected_to(conn) == auth_path(conn, :show, auth)

      conn = get conn, auth_path(conn, :show, auth)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, auth: auth} do
      conn = put conn, auth_path(conn, :update, auth), auth: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Auth"
    end
  end

  describe "delete auth" do
    setup [:create_auth]

    test "deletes chosen auth", %{conn: conn, auth: auth} do
      conn = delete conn, auth_path(conn, :delete, auth)
      assert redirected_to(conn) == auth_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, auth_path(conn, :show, auth)
      end
    end
  end

  defp create_auth(_) do
    auth = fixture(:auth)
    {:ok, auth: auth}
  end
end
