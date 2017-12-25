defmodule BshipWeb.AuthController do
  use BshipWeb, :controller

  alias Bship.User
  alias Bship.User.UserInfo

  def auth_error(conn, {type, _reason}, _opts) do
    body = Poison.encode!(%{message: to_string(type)})
    case conn.request_path do
      "/lobbies"<>_id ->
        conn
        |> put_flash(:error, gettext("请先登录后,再进入游戏厅"))
        |> redirect(to: auth_path(conn, :sign_in))
      _ ->
        send_resp(conn, 401, body)
    end
  end

  # 注册页面
  def sign_up(conn, _params) do
    changeset = User.change_user_info(%UserInfo{})
    render(conn, "sign_up.html", changeset: changeset)
  end

  # 注册
  def do_sign_up(conn, %{"user_info" => auth_params}) do
    case User.create_user_info(auth_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext "Sign up successfully.")
        |> Bship.Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "sign_up.html", changeset: changeset)
    end
  end

  # 登录页面
  def sign_in(conn, _params) do
    changeset = User.change_user_info(%UserInfo{})
    render(conn, "sign_in.html", changeset: changeset)
  end

  # 登录
  def do_sign_in(conn, %{"user_info" => %{"pwd" => pwd, "account" => account}}) do
    user = User.get_user_by_account(account)
    case User.check_auth(user, pwd) do
      true ->
        conn
        |> put_flash(:info, gettext("Sign in successfully."))
        |> Bship.Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))
      false ->
        conn
        |> put_flash(:error, gettext("Account or Password is invaild."))
        |> render("sign_in.html", changeset: User.change_user_info(%UserInfo{}))
    end
  end

  # 退出
  def do_sign_out(conn, %{}) do
    conn
    |> Bship.Guardian.Plug.sign_out()
    |> put_flash(:info, gettext "Sign out successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  # 修改密码页面
  def chg_pwd(conn, %{}) do
    changeset = User.change_user_info(%UserInfo{})
    render(conn, "chg_pwd.html", changeset: changeset)
  end

  # 修改密码
  def do_chg_pwd(conn, auth_params) do
    user = case Bship.Guardian.Plug.current_resource(conn) do
      nil ->
        User.get_user_by_account(auth_params["account"] || "")
      user ->
        user
    end
    case User.chg_pwd(user, auth_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext "Password change successfully.")
        |> redirect(to: page_path(conn, :index, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "change_pwd.html", changeset: changeset)
    end
  end

end
