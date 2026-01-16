defmodule LiveschoolWeb.BankTransactionLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.BankTransactions
  alias Liveschool.BankTransactions.BankTransaction

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bank_transactions, BankTransactions.list_bank_transactions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bank transaction")
    |> assign(:bank_transaction, BankTransactions.get_bank_transaction!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bank transaction")
    |> assign(:bank_transaction, %BankTransaction{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bank transactions")
    |> assign(:bank_transaction, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.BankTransactionLive.FormComponent, {:saved, bank_transaction}}, socket) do
    {:noreply, stream_insert(socket, :bank_transactions, bank_transaction)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bank_transaction = BankTransactions.get_bank_transaction!(id)
    {:ok, _} = BankTransactions.delete_bank_transaction(bank_transaction)

    {:noreply, stream_delete(socket, :bank_transactions, bank_transaction)}
  end
end
