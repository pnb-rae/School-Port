defmodule LiveschoolWeb.FeeReceiptLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeReceipts
  alias Liveschool.FeeReceipts.FeeReceipt

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fee_receipts, FeeReceipts.list_fee_receipts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fee receipt")
    |> assign(:fee_receipt, FeeReceipts.get_fee_receipt!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fee receipt")
    |> assign(:fee_receipt, %FeeReceipt{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fee receipts")
    |> assign(:fee_receipt, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.FeeReceiptLive.FormComponent, {:saved, fee_receipt}}, socket) do
    {:noreply, stream_insert(socket, :fee_receipts, fee_receipt)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fee_receipt = FeeReceipts.get_fee_receipt!(id)
    {:ok, _} = FeeReceipts.delete_fee_receipt(fee_receipt)

    {:noreply, stream_delete(socket, :fee_receipts, fee_receipt)}
  end
end
