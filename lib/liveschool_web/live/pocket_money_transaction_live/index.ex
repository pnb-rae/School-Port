defmodule LiveschoolWeb.PocketMoneyTransactionLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.PocketMoneyTransactions
  alias Liveschool.PocketMoneyTransactions.PocketMoneyTransaction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :pocket_money_transactions, PocketMoneyTransactions.list_pocket_money_transactions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pocket money transaction")
    |> assign(:pocket_money_transaction, PocketMoneyTransactions.get_pocket_money_transaction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pocket money transaction")
    |> assign(:pocket_money_transaction, %PocketMoneyTransaction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pocket money transactions")
    |> assign(:pocket_money_transaction, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.PocketMoneyTransactionLive.FormComponent, {:saved, pocket_money_transaction}}, socket) do
    {:noreply, stream_insert(socket, :pocket_money_transactions, pocket_money_transaction)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pocket_money_transaction = PocketMoneyTransactions.get_pocket_money_transaction!(id)
    {:ok, _} = PocketMoneyTransactions.delete_pocket_money_transaction(pocket_money_transaction)

    {:noreply, stream_delete(socket, :pocket_money_transactions, pocket_money_transaction)}
  end
end
