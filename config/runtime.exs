import Config

if config_env() == :prod do
  listen_port = String.to_integer(System.get_env("PORT") || "4000")

  config :sample_phoenix_app_with_postgres_db, SamplePhoenixAppWithPostgresDB.Repo,
    ssl: false,
    url: System.fetch_env!("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  config :sample_phoenix_app_with_postgres_db, SamplePhoenixAppWithPostgresDBWeb.Endpoint,
    http: [
      port: listen_port,
      transport_options: [
        socket_opts: [:inet6]
      ]
    ],
    live_view: [
      signing_salt: System.fetch_env!("LIVE_VIEW_SIGNING_SALT")
    ],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
    url: [
      host: System.fetch_env!("CANONICAL_HOST"),
      port: 443
    ]
end
