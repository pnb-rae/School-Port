defmodule LiveschoolWeb.PocketMoneyTransactionLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.PocketMoneyTransactions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:pocket_money_transaction, PocketMoneyTransactions.get_pocket_money_transaction!(id))}
  end

  defp page_title(:show), do: "Show Pocket money transaction"
  defp page_title(:edit), do: "Edit Pocket money transaction"
end
