defmodule Amnesia.Repo do
  use Ecto.Repo,
    otp_app: :amnesia,
    adapter: Ecto.Adapters.Postgres
end
