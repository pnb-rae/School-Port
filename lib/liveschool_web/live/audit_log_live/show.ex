defmodule LiveschoolWeb.AuditLogLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.AuditLogs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:audit_log, AuditLogs.get_audit_log!(id))}
  end

  defp page_title(:show), do: "Show Audit log"
  defp page_title(:edit), do: "Edit Audit log"
end
