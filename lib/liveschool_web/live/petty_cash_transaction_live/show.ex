defmodule LiveschoolWeb.PettyCashTransactionLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.PettyCashTransactions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:petty_cash_transaction, PettyCashTransactions.get_petty_cash_transaction!(id))}
  end

  defp page_title(:show), do: "Show Petty cash transaction"
  defp page_title(:edit), do: "Edit Petty cash transaction"
end
