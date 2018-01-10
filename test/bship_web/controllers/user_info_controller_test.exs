defmodule BshipWeb.UserInfoControllerTest do
  use BshipWeb.ConnCase

#  alias Bship.User
#
#  @create_attrs %{account: "some account", nick: "some nick", pwd_hash: "some pwd_hash"}
#  @update_attrs %{account: "some updated account", nick: "some updated nick", pwd_hash: "some updated pwd_hash"}
#  @invalid_attrs %{account: nil, nick: nil, pwd_hash: nil}
#
#  def fixture(:user_info) do
#    {:ok, user_info} = User.create_user_info(@create_attrs)
#    user_info
#  end
#
#  describe "index" do
#    test "lists all users", %{conn: conn} do
#      conn = get conn, user_info_path(conn, :index)
#      assert html_response(conn, 200) =~ "Listing Users"
#    end
#  end
#
#  describe "new user_info" do
#    test "renders form", %{conn: conn} do
#      conn = get conn, user_info_path(conn, :new)
#      assert html_response(conn, 200) =~ "New User info"
#    end
#  end
#
#  describe "create user_info" do
#    test "redirects to show when data is valid", %{conn: conn} do
#      conn = post conn, user_info_path(conn, :create), user_info: @create_attrs
#
#      assert %{id: id} = redirected_params(conn)
#      assert redirected_to(conn) == user_info_path(conn, :show, id)
#
#      conn = get conn, user_info_path(conn, :show, id)
#      assert html_response(conn, 200) =~ "Show User info"
#    end
#
#    test "renders errors when data is invalid", %{conn: conn} do
#      conn = post conn, user_info_path(conn, :create), user_info: @invalid_attrs
#      assert html_response(conn, 200) =~ "New User info"
#    end
#  end
#
#  describe "edit user_info" do
#    setup [:create_user_info]
#
#    test "renders form for editing chosen user_info", %{conn: conn, user_info: user_info} do
#      conn = get conn, user_info_path(conn, :edit, user_info)
#      assert html_response(conn, 200) =~ "Edit User info"
#    end
#  end
#
#  describe "update user_info" do
#    setup [:create_user_info]
#
#    test "redirects when data is valid", %{conn: conn, user_info: user_info} do
#      conn = put conn, user_info_path(conn, :update, user_info), user_info: @update_attrs
#      assert redirected_to(conn) == user_info_path(conn, :show, user_info)
#
#      conn = get conn, user_info_path(conn, :show, user_info)
#      assert html_response(conn, 200) =~ "some updated account"
#    end
#
#    test "renders errors when data is invalid", %{conn: conn, user_info: user_info} do
#      conn = put conn, user_info_path(conn, :update, user_info), user_info: @invalid_attrs
#      assert html_response(conn, 200) =~ "Edit User info"
#    end
#  end
#
#  describe "delete user_info" do
#    setup [:create_user_info]
#
#    test "deletes chosen user_info", %{conn: conn, user_info: user_info} do
#      conn = delete conn, user_info_path(conn, :delete, user_info)
#      assert redirected_to(conn) == user_info_path(conn, :index)
#      assert_error_sent 404, fn ->
#        get conn, user_info_path(conn, :show, user_info)
#      end
#    end
#  end
#
#  defp create_user_info(_) do
#    user_info = fixture(:user_info)
#    {:ok, user_info: user_info}
#  end
end
