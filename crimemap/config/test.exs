use Mix.Config

# Configure your database
config :crimemap, Crimemap.Repo,
  username: "postgres",
  password: "postgres",
  database: "crimemap_test",
  hostname: "localhost",
  types: Crimemap.PostgrexTypes,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :crimemap, CrimemapWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
