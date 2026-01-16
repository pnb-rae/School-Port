defmodule LiveschoolWeb.DepartmentLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Departments

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage department records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="department-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:code]} type="text" label="Code" />
        <.input field={@form[:budget_allocation]} type="number" label="Budget allocation" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Department</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{department: department} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Departments.change_department(department))
     end)}
  end

  @impl true
  def handle_event("validate", %{"department" => department_params}, socket) do
    changeset = Departments.change_department(socket.assigns.department, department_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"department" => department_params}, socket) do
    save_department(socket, socket.assigns.action, department_params)
  end

  defp save_department(socket, :edit, department_params) do
    case Departments.update_department(socket.assigns.department, department_params) do
      {:ok, department} ->
        notify_parent({:saved, department})

        {:noreply,
         socket
         |> put_flash(:info, "Department updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_department(socket, :new, department_params) do
    case Departments.create_department(department_params) do
      {:ok, department} ->
        notify_parent({:saved, department})

        {:noreply,
         socket
         |> put_flash(:info, "Department created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
