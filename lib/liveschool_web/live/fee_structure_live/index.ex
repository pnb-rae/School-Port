defmodule LiveschoolWeb.FeeStructureLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeStructures
  alias Liveschool.FeeStructures.FeeStructure

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fee_structures, FeeStructures.list_fee_structures())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fee structure")
    |> assign(:fee_structure, FeeStructures.get_fee_structure!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fee structure")
    |> assign(:fee_structure, %FeeStructure{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fee structures")
    |> assign(:fee_structure, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.FeeStructureLive.FormComponent, {:saved, fee_structure}}, socket) do
    {:noreply, stream_insert(socket, :fee_structures, fee_structure)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fee_structure = FeeStructures.get_fee_structure!(id)
    {:ok, _} = FeeStructures.delete_fee_structure(fee_structure)

    {:noreply, stream_delete(socket, :fee_structures, fee_structure)}
  end
end
