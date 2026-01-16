defmodule LiveschoolWeb.StudentFeeAllocationLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.StudentFeeAllocations
  alias Liveschool.StudentFeeAllocations.StudentFeeAllocation

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :student_fee_allocations, StudentFeeAllocations.list_student_fee_allocations())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Student fee allocation")
    |> assign(:student_fee_allocation, StudentFeeAllocations.get_student_fee_allocation!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Student fee allocation")
    |> assign(:student_fee_allocation, %StudentFeeAllocation{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Student fee allocations")
    |> assign(:student_fee_allocation, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.StudentFeeAllocationLive.FormComponent, {:saved, student_fee_allocation}}, socket) do
    {:noreply, stream_insert(socket, :student_fee_allocations, student_fee_allocation)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    student_fee_allocation = StudentFeeAllocations.get_student_fee_allocation!(id)
    {:ok, _} = StudentFeeAllocations.delete_student_fee_allocation(student_fee_allocation)

    {:noreply, stream_delete(socket, :student_fee_allocations, student_fee_allocation)}
  end
end
