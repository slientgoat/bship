defmodule BshipWeb.PageControllerTest do
  use BshipWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<html"
  end
end
