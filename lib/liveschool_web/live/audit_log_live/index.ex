defmodule LiveschoolWeb.AuditLogLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.AuditLogs
  alias Liveschool.AuditLogs.AuditLog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :audit_logs, AuditLogs.list_audit_logs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Audit log")
    |> assign(:audit_log, AuditLogs.get_audit_log!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Audit log")
    |> assign(:audit_log, %AuditLog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Audit logs")
    |> assign(:audit_log, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.AuditLogLive.FormComponent, {:saved, audit_log}}, socket) do
    {:noreply, stream_insert(socket, :audit_logs, audit_log)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    audit_log = AuditLogs.get_audit_log!(id)
    {:ok, _} = AuditLogs.delete_audit_log(audit_log)

    {:noreply, stream_delete(socket, :audit_logs, audit_log)}
  end
end
