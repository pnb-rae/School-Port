defmodule Liveschool.AuditLogsTest do
  use Liveschool.DataCase

  alias Liveschool.AuditLogs

  describe "audit_logs" do
    alias Liveschool.AuditLogs.AuditLog

    import Liveschool.AuditLogsFixtures

    @invalid_attrs %{action: nil, table_name: nil, record_id: nil, old_values: nil, new_values: nil, ip_address: nil}

    test "list_audit_logs/0 returns all audit_logs" do
      audit_log = audit_log_fixture()
      assert AuditLogs.list_audit_logs() == [audit_log]
    end

    test "get_audit_log!/1 returns the audit_log with given id" do
      audit_log = audit_log_fixture()
      assert AuditLogs.get_audit_log!(audit_log.id) == audit_log
    end

    test "create_audit_log/1 with valid data creates a audit_log" do
      valid_attrs = %{action: "some action", table_name: "some table_name", record_id: 42, old_values: %{}, new_values: %{}, ip_address: "some ip_address"}

      assert {:ok, %AuditLog{} = audit_log} = AuditLogs.create_audit_log(valid_attrs)
      assert audit_log.action == "some action"
      assert audit_log.table_name == "some table_name"
      assert audit_log.record_id == 42
      assert audit_log.old_values == %{}
      assert audit_log.new_values == %{}
      assert audit_log.ip_address == "some ip_address"
    end

    test "create_audit_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AuditLogs.create_audit_log(@invalid_attrs)
    end

    test "update_audit_log/2 with valid data updates the audit_log" do
      audit_log = audit_log_fixture()
      update_attrs = %{action: "some updated action", table_name: "some updated table_name", record_id: 43, old_values: %{}, new_values: %{}, ip_address: "some updated ip_address"}

      assert {:ok, %AuditLog{} = audit_log} = AuditLogs.update_audit_log(audit_log, update_attrs)
      assert audit_log.action == "some updated action"
      assert audit_log.table_name == "some updated table_name"
      assert audit_log.record_id == 43
      assert audit_log.old_values == %{}
      assert audit_log.new_values == %{}
      assert audit_log.ip_address == "some updated ip_address"
    end

    test "update_audit_log/2 with invalid data returns error changeset" do
      audit_log = audit_log_fixture()
      assert {:error, %Ecto.Changeset{}} = AuditLogs.update_audit_log(audit_log, @invalid_attrs)
      assert audit_log == AuditLogs.get_audit_log!(audit_log.id)
    end

    test "delete_audit_log/1 deletes the audit_log" do
      audit_log = audit_log_fixture()
      assert {:ok, %AuditLog{}} = AuditLogs.delete_audit_log(audit_log)
      assert_raise Ecto.NoResultsError, fn -> AuditLogs.get_audit_log!(audit_log.id) end
    end

    test "change_audit_log/1 returns a audit_log changeset" do
      audit_log = audit_log_fixture()
      assert %Ecto.Changeset{} = AuditLogs.change_audit_log(audit_log)
    end
  end
end
