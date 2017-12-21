defmodule BshipWeb.PageController do
  use BshipWeb, :controller
  alias Bship.App
  def index(conn, _params) do
    apps = App.list_apps()
    render conn, "index.html", apps: apps
  end
end
