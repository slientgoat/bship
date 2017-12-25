defmodule BshipWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "lobby:*", BshipWeb.LobbyChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"token" => token,"locale"=>locale}, socket) do
    case Guardian.Phoenix.Socket.authenticate(socket, Bship.Guardian, token) do
      {:ok, authed_socket} ->
        authed_socket = authed_socket
        |> assign(:user,Guardian.Phoenix.Socket.current_resource(authed_socket))
        |> assign(:locale,locale)
        {:ok, authed_socket}
      {:error, _} -> :error
    end
  end
  def connect(_params, _socket) do
    :error
  end

  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
