defmodule LiveschoolWeb.FeeWaiverLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeWaivers

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fee_waiver, FeeWaivers.get_fee_waiver!(id))}
  end

  defp page_title(:show), do: "Show Fee waiver"
  defp page_title(:edit), do: "Edit Fee waiver"
end
