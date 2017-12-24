defmodule BshipWeb.LobbyController do
  use BshipWeb, :controller

  alias Bship.App

  def show(conn, %{"id" => id}) do
    conn = put_layout(conn, false)
    lobby = App.get_app_info!(id)
    introduce= "#{lobby.name}-introduce"
    rules= "#{lobby.name}-rules"
#    texts = %{
#      introduce: "a",
#      rules: "b"
#    }
    texts = %{
      introduce: Gettext.dgettext(BshipWeb.Gettext, "lobby", introduce),
      rules: Gettext.dgettext(BshipWeb.Gettext, "lobby", rules)
    }
    render(conn, "show.html", lobby: lobby, texts: texts)
  end

end
