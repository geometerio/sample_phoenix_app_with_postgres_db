defmodule SamplePhoenixAppWithPostgresDb.Repo do
  use Ecto.Repo,
    otp_app: :sample_phoenix_app_with_postgres_db,
    adapter: Ecto.Adapters.Postgres
end
