defmodule LiveschoolWeb.ExpenditureLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.Expenditures
  alias Liveschool.Expenditures.Expenditure

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :expenditures, Expenditures.list_expenditures())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Expenditure")
    |> assign(:expenditure, Expenditures.get_expenditure!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Expenditure")
    |> assign(:expenditure, %Expenditure{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Expenditures")
    |> assign(:expenditure, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.ExpenditureLive.FormComponent, {:saved, expenditure}}, socket) do
    {:noreply, stream_insert(socket, :expenditures, expenditure)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    expenditure = Expenditures.get_expenditure!(id)
    {:ok, _} = Expenditures.delete_expenditure(expenditure)

    {:noreply, stream_delete(socket, :expenditures, expenditure)}
  end
end
