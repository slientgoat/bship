defmodule BshipWeb.UserInfoController do
  use BshipWeb, :controller

  alias Bship.User
  alias Bship.User.UserInfo

  def index(conn, _params) do
    users = User.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.change_user_info(%UserInfo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_info" => user_info_params}) do
    case User.create_user_info(user_info_params) do
      {:ok, user_info} ->
        conn
        |> put_flash(:info, "User info created successfully.")
        |> redirect(to: user_info_path(conn, :show, user_info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_info = User.get_user_info!(id)
    render(conn, "show.html", user_info: user_info)
  end

  def edit(conn, %{"id" => id}) do
    user_info = User.get_user_info!(id)
    changeset = User.change_user_info(user_info)
    render(conn, "edit.html", user_info: user_info, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_info" => user_info_params}) do
    user_info = User.get_user_info!(id)

    case User.update_user_info(user_info, user_info_params) do
      {:ok, user_info} ->
        conn
        |> put_flash(:info, "User info updated successfully.")
        |> redirect(to: user_info_path(conn, :show, user_info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user_info: user_info, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_info = User.get_user_info!(id)
    {:ok, _user_info} = User.delete_user_info(user_info)

    conn
    |> put_flash(:info, "User info deleted successfully.")
    |> redirect(to: user_info_path(conn, :index))
  end
end
