defmodule LiveschoolWeb.ExpenditureLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.Expenditures

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:expenditure, Expenditures.get_expenditure!(id))}
  end

  defp page_title(:show), do: "Show Expenditure"
  defp page_title(:edit), do: "Edit Expenditure"
end
