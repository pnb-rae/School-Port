defmodule Liveschool.AuditLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.AuditLogs` context.
  """

  @doc """
  Generate a audit_log.
  """
  def audit_log_fixture(attrs \\ %{}) do
    {:ok, audit_log} =
      attrs
      |> Enum.into(%{
        action: "some action",
        ip_address: "some ip_address",
        new_values: %{},
        old_values: %{},
        record_id: 42,
        table_name: "some table_name"
      })
      |> Liveschool.AuditLogs.create_audit_log()

    audit_log
  end
end
