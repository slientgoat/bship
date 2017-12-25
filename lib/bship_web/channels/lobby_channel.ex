defmodule BshipWeb.LobbyChannel do
  use BshipWeb, :channel
  alias BshipWeb.Presence
  def join("lobby:"<>_lobby_id, payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    Gettext.put_locale(BshipWeb.Gettext, socket.assigns[:locale])
    push socket, "presence_state", Presence.list(socket)
    user = socket.assigns.user
    {:ok, _} = Presence.track(socket, user.id, %{
      online_at: inspect(System.system_time(:seconds)),
      nick: user.nick
    })
    {:noreply, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body,from: socket.assigns.user.id}
    {:noreply, socket}
  end

  intercept ["new_msg"]

  def handle_out("new_msg", %{body: body,from: from}, socket) do
    nick = if from == socket.assigns.user.id,do: lobby_text("您"),else: socket.assigns.user.nick
    push socket, "new_msg", %{body: body,nick: nick}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end
