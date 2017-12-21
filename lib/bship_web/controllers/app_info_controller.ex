defmodule BshipWeb.AppInfoController do
  use BshipWeb, :controller

  alias Bship.App
  alias Bship.App.AppInfo

  def show_all(conn, params) do
    index(conn,params)
  end

  def index(conn, _params) do
    apps = App.list_apps()
    render(conn, "index.html", apps: apps)
  end

  def new(conn, _params) do
    changeset = App.change_app_info(%AppInfo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"app_info" => app_info_params}) do
    case App.create_app_info(app_info_params) do
      {:ok, app_info} ->
        conn
        |> put_flash(:info, "App info created successfully.")
        |> redirect(to: app_info_path(conn, :show, app_info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    app_info = App.get_app_info!(id)
    render(conn, "show.html", app_info: app_info)
  end

  def edit(conn, %{"id" => id}) do
    app_info = App.get_app_info!(id)
    changeset = App.change_app_info(app_info)
    render(conn, "edit.html", app_info: app_info, changeset: changeset)
  end

  def update(conn, %{"id" => id, "app_info" => app_info_params}) do
    app_info = App.get_app_info!(id)

    case App.update_app_info(app_info, app_info_params) do
      {:ok, app_info} ->
        conn
        |> put_flash(:info, "App info updated successfully.")
        |> redirect(to: app_info_path(conn, :show, app_info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", app_info: app_info, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    app_info = App.get_app_info!(id)
    {:ok, _app_info} = App.delete_app_info(app_info)

    conn
    |> put_flash(:info, "App info deleted successfully.")
    |> redirect(to: app_info_path(conn, :index))
  end
end
