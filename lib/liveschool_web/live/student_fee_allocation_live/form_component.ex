defmodule LiveschoolWeb.StudentFeeAllocationLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.StudentFeeAllocations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage student_fee_allocation records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="student_fee_allocation-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount_due]} type="number" label="Amount due" step="any" />
        <.input field={@form[:amount_paid]} type="number" label="Amount paid" step="any" />
        <.input field={@form[:balance]} type="number" label="Balance" step="any" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:due_date]} type="date" label="Due date" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:term]} type="text" label="Term" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Student fee allocation</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{student_fee_allocation: student_fee_allocation} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(StudentFeeAllocations.change_student_fee_allocation(student_fee_allocation))
     end)}
  end

  @impl true
  def handle_event("validate", %{"student_fee_allocation" => student_fee_allocation_params}, socket) do
    changeset = StudentFeeAllocations.change_student_fee_allocation(socket.assigns.student_fee_allocation, student_fee_allocation_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"student_fee_allocation" => student_fee_allocation_params}, socket) do
    save_student_fee_allocation(socket, socket.assigns.action, student_fee_allocation_params)
  end

  defp save_student_fee_allocation(socket, :edit, student_fee_allocation_params) do
    case StudentFeeAllocations.update_student_fee_allocation(socket.assigns.student_fee_allocation, student_fee_allocation_params) do
      {:ok, student_fee_allocation} ->
        notify_parent({:saved, student_fee_allocation})

        {:noreply,
         socket
         |> put_flash(:info, "Student fee allocation updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_student_fee_allocation(socket, :new, student_fee_allocation_params) do
    case StudentFeeAllocations.create_student_fee_allocation(student_fee_allocation_params) do
      {:ok, student_fee_allocation} ->
        notify_parent({:saved, student_fee_allocation})

        {:noreply,
         socket
         |> put_flash(:info, "Student fee allocation created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
