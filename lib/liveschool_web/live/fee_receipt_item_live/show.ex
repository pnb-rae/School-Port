defmodule LiveschoolWeb.FeeReceiptItemLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeReceiptItems

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:fee_receipt_item, FeeReceiptItems.get_fee_receipt_item!(id))}
  end

  defp page_title(:show), do: "Show Fee receipt item"
  defp page_title(:edit), do: "Edit Fee receipt item"
end
