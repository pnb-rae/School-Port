defmodule LiveschoolWeb.FeeWaiverLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.FeeWaivers
  alias Liveschool.FeeWaivers.FeeWaiver

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :fee_waivers, FeeWaivers.list_fee_waivers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Fee waiver")
    |> assign(:fee_waiver, FeeWaivers.get_fee_waiver!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Fee waiver")
    |> assign(:fee_waiver, %FeeWaiver{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fee waivers")
    |> assign(:fee_waiver, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.FeeWaiverLive.FormComponent, {:saved, fee_waiver}}, socket) do
    {:noreply, stream_insert(socket, :fee_waivers, fee_waiver)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    fee_waiver = FeeWaivers.get_fee_waiver!(id)
    {:ok, _} = FeeWaivers.delete_fee_waiver(fee_waiver)

    {:noreply, stream_delete(socket, :fee_waivers, fee_waiver)}
  end
end
