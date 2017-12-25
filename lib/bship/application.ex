defmodule Bship.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Bship.Repo, []),
      # Start the endpoint when the application starts
      supervisor(BshipWeb.Endpoint, []),
      supervisor(BshipWeb.Presence, []),
      # Start your own worker by calling: Bship.Worker.start_link(arg1, arg2, arg3)
      # worker(Bship.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bship.Supervisor]
    result = Supervisor.start_link(children, opts)
    Bship.init()
    result
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BshipWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
