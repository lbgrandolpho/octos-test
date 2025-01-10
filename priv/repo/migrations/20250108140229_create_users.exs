defmodule OctosTest.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :status, :string, null: false, default: "active"
      add :deactivated_at, :utc_datetime, defaul: nil

      timestamps(type: :utc_datetime)
    end
  end
end
