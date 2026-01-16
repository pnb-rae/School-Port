defmodule LiveschoolWeb.FeeStructureLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeStructures

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fee_structure, FeeStructures.get_fee_structure!(id))}
  end

  defp page_title(:show), do: "Show Fee structure"
  defp page_title(:edit), do: "Edit Fee structure"
end
