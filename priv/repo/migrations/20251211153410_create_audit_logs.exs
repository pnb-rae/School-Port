defmodule Liveschool.Repo.Migrations.CreateAuditLogs do
  use Ecto.Migration

  def change do
    create table(:audit_logs) do
      add :action, :string
      add :table_name, :string
      add :record_id, :integer
      add :old_values, :map
      add :new_values, :map
      add :ip_address, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:audit_logs, [:user_id])
    create index(:audit_logs, [:school_id])
  end
end
