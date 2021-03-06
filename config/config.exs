# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sample_phoenix_app_with_postgres_db,
  ecto_repos: [SamplePhoenixAppWithPostgresDB.Repo]

# Configures the endpoint
config :sample_phoenix_app_with_postgres_db, SamplePhoenixAppWithPostgresDBWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VwLiwxfkqeR7/n8Z7R/mH/grvN+NzuhHBFzIM7vQJNNa5cpKliIhLMKRsLq9oFG7",
  render_errors: [view: SamplePhoenixAppWithPostgresDBWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SamplePhoenixAppWithPostgresDB.PubSub,
  live_view: [signing_salt: "tILiyzBE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
