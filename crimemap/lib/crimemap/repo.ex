defmodule Crimemap.Repo do
  use Ecto.Repo,
    otp_app: :crimemap,
    adapter: Ecto.Adapters.Postgres
end
