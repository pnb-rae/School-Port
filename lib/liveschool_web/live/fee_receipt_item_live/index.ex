defmodule LiveschoolWeb.FeeReceiptItemLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeReceiptItems
  alias Liveschool.FeeReceiptItems.FeeReceiptItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fee_receipt_items, FeeReceiptItems.list_fee_receipt_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fee receipt item")
    |> assign(:fee_receipt_item, FeeReceiptItems.get_fee_receipt_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fee receipt item")
    |> assign(:fee_receipt_item, %FeeReceiptItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fee receipt items")
    |> assign(:fee_receipt_item, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.FeeReceiptItemLive.FormComponent, {:saved, fee_receipt_item}}, socket) do
    {:noreply, stream_insert(socket, :fee_receipt_items, fee_receipt_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fee_receipt_item = FeeReceiptItems.get_fee_receipt_item!(id)
    {:ok, _} = FeeReceiptItems.delete_fee_receipt_item(fee_receipt_item)

    {:noreply, stream_delete(socket, :fee_receipt_items, fee_receipt_item)}
  end
end
