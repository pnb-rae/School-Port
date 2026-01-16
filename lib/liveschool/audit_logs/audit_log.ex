defmodule Liveschool.AuditLogs.AuditLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "audit_logs" do
    field :action, :string
    field :table_name, :string
    field :record_id, :integer
    field :old_values, :map
    field :new_values, :map
    field :ip_address, :string
    field :user_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(audit_log, attrs) do
    audit_log
    |> cast(attrs, [:action, :table_name, :record_id, :old_values, :new_values, :ip_address])
    |> validate_required([:action, :table_name, :record_id, :ip_address])
  end
end
