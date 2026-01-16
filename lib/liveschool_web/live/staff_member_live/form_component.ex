defmodule LiveschoolWeb.StaffMemberLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Staff

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage staff_member records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="staff_member-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:staff_number]} type="text" label="Staff number" />
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <.input field={@form[:hire_date]} type="date" label="Hire date" />
        <.input field={@form[:position]} type="text" label="Position" />
        <.input field={@form[:salary]} type="number" label="Salary" step="any" />
        <.input field={@form[:account_number]} type="text" label="Account number" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Staff member</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{staff_member: staff_member} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Staff.change_staff_member(staff_member))
     end)}
  end

  @impl true
  def handle_event("validate", %{"staff_member" => staff_member_params}, socket) do
    changeset = Staff.change_staff_member(socket.assigns.staff_member, staff_member_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"staff_member" => staff_member_params}, socket) do
    save_staff_member(socket, socket.assigns.action, staff_member_params)
  end

  defp save_staff_member(socket, :edit, staff_member_params) do
    case Staff.update_staff_member(socket.assigns.staff_member, staff_member_params) do
      {:ok, staff_member} ->
        notify_parent({:saved, staff_member})

        {:noreply,
         socket
         |> put_flash(:info, "Staff member updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_staff_member(socket, :new, staff_member_params) do
    case Staff.create_staff_member(staff_member_params) do
      {:ok, staff_member} ->
        notify_parent({:saved, staff_member})

        {:noreply,
         socket
         |> put_flash(:info, "Staff member created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
