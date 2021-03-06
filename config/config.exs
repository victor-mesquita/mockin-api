# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mockin, ecto_repos: [Mockin.Repo]

config :mockin, MockinWeb.Gettext, locales: ~w(en pt_BR), default_locale: "pt_BR"

# Configures the endpoint
config :mockin, MockinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9ueg5YcX8/LKzVUcDrXp5xpYuaBCUfZZAJ3/udC1LCoabotR3O1CJyf/u/6RLJ/N",
  render_errors: [view: MockinWeb.ErrorView, accepts: ~w(json)],
  pubsub_server: Mockin.PubSub,
  front_end_reset_password_url: "http://localhost:8080/#/reset-password/{token}"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mockin, :pow,
  user: Mockin.Model.User,
  repo: Mockin.Repo,
  extensions: [PowEmailConfirmation, PowResetPassword],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: MockinWeb.Pow.Mailer,
  web_mailer_module: MockinWeb

config :mockin, MockinWeb.Pow.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "mail.brq.com",
  hostname: "brq.com",
  port: 25,
  ssl: false,
  tls: :if_available,
  no_mx_lookups: false,
  auth: :if_available

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
