defmodule LiveschoolWeb.FeeArrearLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeArrears
  alias Liveschool.FeeArrears.FeeArrear

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fee_arrears, FeeArrears.list_fee_arrears())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fee arrear")
    |> assign(:fee_arrear, FeeArrears.get_fee_arrear!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fee arrear")
    |> assign(:fee_arrear, %FeeArrear{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fee arrears")
    |> assign(:fee_arrear, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.FeeArrearLive.FormComponent, {:saved, fee_arrear}}, socket) do
    {:noreply, stream_insert(socket, :fee_arrears, fee_arrear)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fee_arrear = FeeArrears.get_fee_arrear!(id)
    {:ok, _} = FeeArrears.delete_fee_arrear(fee_arrear)

    {:noreply, stream_delete(socket, :fee_arrears, fee_arrear)}
  end
end
