defmodule LiveschoolWeb.DepartmentLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.Departments
  alias Liveschool.Departments.Department

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :departments, Departments.list_departments())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Department")
    |> assign(:department, Departments.get_department!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Department")
    |> assign(:department, %Department{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Departments")
    |> assign(:department, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.DepartmentLive.FormComponent, {:saved, department}}, socket) do
    {:noreply, stream_insert(socket, :departments, department)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    department = Departments.get_department!(id)
    {:ok, _} = Departments.delete_department(department)

    {:noreply, stream_delete(socket, :departments, department)}
  end
end
