defmodule BshipWeb.LobbyController do
  use BshipWeb, :controller

  alias Bship.App

  def show(conn, %{"id" => id}) do
    lobby = App.get_app_info!(id)
    render(conn, "show.html", lobby: lobby)
  end

end
