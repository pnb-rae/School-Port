defmodule LiveschoolWeb.FeeArrearLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeArrears

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fee_arrear, FeeArrears.get_fee_arrear!(id))}
  end

  defp page_title(:show), do: "Show Fee arrear"
  defp page_title(:edit), do: "Edit Fee arrear"
end
