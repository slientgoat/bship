# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bship,
  ecto_repos: [Bship.Repo]

# Configures the endpoint
config :bship, BshipWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ssAR3gN5v7mB9jT2AI3lvOYLgkbCU0vOPLUe/LhjVTn6u2hBX7I8Yo+Vlpxn5AgV",
  render_errors: [view: BshipWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bship.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bship, Bship.Guardian,
       issuer: "bship",
       secret_key: "fe/HdIyDuEkTAHbznKc8PuqELvMAVoOLmozu8mkcksvJAUBt1tLlUk2tp8R1Z16H"

config :bship, BshipWeb.Gettext,
       default_locale: "zh"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
