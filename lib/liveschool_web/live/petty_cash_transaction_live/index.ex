defmodule LiveschoolWeb.PettyCashTransactionLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.PettyCashTransactions
  alias Liveschool.PettyCashTransactions.PettyCashTransaction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :petty_cash_transactions, PettyCashTransactions.list_petty_cash_transactions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Petty cash transaction")
    |> assign(:petty_cash_transaction, PettyCashTransactions.get_petty_cash_transaction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Petty cash transaction")
    |> assign(:petty_cash_transaction, %PettyCashTransaction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Petty cash transactions")
    |> assign(:petty_cash_transaction, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.PettyCashTransactionLive.FormComponent, {:saved, petty_cash_transaction}}, socket) do
    {:noreply, stream_insert(socket, :petty_cash_transactions, petty_cash_transaction)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    petty_cash_transaction = PettyCashTransactions.get_petty_cash_transaction!(id)
    {:ok, _} = PettyCashTransactions.delete_petty_cash_transaction(petty_cash_transaction)

    {:noreply, stream_delete(socket, :petty_cash_transactions, petty_cash_transaction)}
  end
end
