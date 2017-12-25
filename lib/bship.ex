defmodule Bship do
  @moduledoc """
  Bship keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def init() do
    init_db()
  end

  @doc """
  初始化数据库
  """
  def init_db() do
    opts = [all: true]
    Ecto.Migrator.run(Bship.Repo,migrations_path(),:up,opts)
  end

  @doc """
  获取当前项目migrations路径
  """
  def migrations_path() do
    Application.app_dir(Application.get_application(__MODULE__), "priv/repo/migrations")
  end
end
