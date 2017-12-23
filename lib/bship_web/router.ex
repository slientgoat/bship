defmodule BshipWeb.Router do
  use BshipWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BshipWeb.Plugs.Locale
  end

  pipeline :browser_auth do
    plug Guardian.Plug.Pipeline, module: Bship.Guardian,
                                 error_handler: BshipWeb.AuthController
    plug Guardian.Plug.VerifySession
#    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug :put_user_token
  end

  # 授权页面验证方式-浏览器访问
  pipeline :ensure_authed_access do
    plug Guardian.Plug.EnsureAuthenticated, handler: BshipWeb.AuthController
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BshipWeb do
    pipe_through [:browser,:browser_auth]
    get "/", PageController, :index

  end

  scope "/", BshipWeb do
    pipe_through [:browser, :browser_auth, :ensure_authed_access]
    resources "/apps", AppInfoController
    resources "/users", UserInfoController, except: [:delete]
    resources "/lobbies", LobbyController
  end

  scope "/auth", BshipWeb do
    pipe_through [:browser, :browser_auth] # Use the default browser stack
    get "/sign_in", AuthController, :sign_in
    post "/sign_in", AuthController, :do_sign_in
    get "/sign_up", AuthController, :sign_up
    post "/sign_up", AuthController, :do_sign_up
    get "/sign_out", AuthController, :do_sign_out
    get "/chg_pwd", AuthController, :chg_pwd
    put "/chg_pwd", AuthController, :do_chg_pwd
  end
  # Other scopes may use custom stacks.
  # scope "/api", BshipWeb do
  #   pipe_through :api
  # end

  defp put_user_token(conn, _) do
    if user_token = Bship.Guardian.Plug.current_token(conn) do
      assign(conn, :user_token, user_token)
    else
      conn
    end
  end
end
