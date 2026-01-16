defmodule LiveschoolWeb.BankTransactionLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.BankTransactions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bank_transaction, BankTransactions.get_bank_transaction!(id))}
  end

  defp page_title(:show), do: "Show Bank transaction"
  defp page_title(:edit), do: "Edit Bank transaction"
end
