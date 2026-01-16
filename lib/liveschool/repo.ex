defmodule Liveschool.Repo do
  use Ecto.Repo,
    otp_app: :liveschool,
    adapter: Ecto.Adapters.Postgres
end
