defmodule BshipWeb.Plugs.Locale do
  @moduledoc """
    多语言处理
  """

  import Plug.Conn

  def init(_opts), do: nil

  def call(conn, _opts) do
    case conn.params["locale"] || get_session(conn, :locale) do
      nil     -> conn
      locale  ->
        Gettext.put_locale(BshipWeb.Gettext, locale)
        conn |> put_session(:locale, locale)
    end
  end

end
