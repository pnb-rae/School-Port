defmodule LiveschoolWeb.ImprestIssueLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.ImprestIssues

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:imprest_issue, ImprestIssues.get_imprest_issue!(id))}
  end

  defp page_title(:show), do: "Show Imprest issue"
  defp page_title(:edit), do: "Edit Imprest issue"
end
