defmodule BshipWeb.Element do
  @moduledoc """
  用于定义html元素
  """

  def add_button(conn, tag) do
    common_opts = []
    add_button(conn, tag, common_opts)
  end
  def add_button(conn, "提交" = tag, opts) do
    common_opts = [class: "btn btn-primary"]
    do_add(conn,"add_button.html",tag,opts ++ common_opts)
  end
  def add_button(conn, tag, opts) do
    do_add(conn,"add_button.html",tag,opts)
  end


  def add_a(conn, tag) do
    common_opts = []
    add_a(conn, tag, common_opts)
  end
  def add_a(conn, tag, opts),do: do_add(conn,"add_a.html",tag,opts)

  defp do_add(conn,template,tag,opts) do
    BshipWeb.ShareView.render template, conn: conn, tag: tag, opts: opts
  end
end
