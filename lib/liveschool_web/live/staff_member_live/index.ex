defmodule LiveschoolWeb.StaffMemberLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.Staff
  alias Liveschool.Staff.StaffMember

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :staff_members, Staff.list_staff_members())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Staff member")
    |> assign(:staff_member, Staff.get_staff_member!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Staff member")
    |> assign(:staff_member, %StaffMember{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Staff members")
    |> assign(:staff_member, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.StaffMemberLive.FormComponent, {:saved, staff_member}}, socket) do
    {:noreply, stream_insert(socket, :staff_members, staff_member)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    staff_member = Staff.get_staff_member!(id)
    {:ok, _} = Staff.delete_staff_member(staff_member)

    {:noreply, stream_delete(socket, :staff_members, staff_member)}
  end
end
