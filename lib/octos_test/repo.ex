defmodule OctosTest.Repo do
  use Ecto.Repo,
    otp_app: :octos_test,
    adapter: Ecto.Adapters.Postgres
end
