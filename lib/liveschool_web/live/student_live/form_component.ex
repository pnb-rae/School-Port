defmodule LiveschoolWeb.StudentLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Students

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage student records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="student-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:admission_number]} type="text" label="Admission number" />
        <.input field={@form[:first_name]} type="text" label="First name" />
        <.input field={@form[:middle_name]} type="text" label="Middle name" />
        <.input field={@form[:last_name]} type="text" label="Last name" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <.input field={@form[:gender]} type="text" label="Gender" />
        <.input field={@form[:photo_url]} type="text" label="Photo url" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:parent_guardian_name]} type="text" label="Parent guardian name" />
        <.input field={@form[:parent_guardian_phone]} type="text" label="Parent guardian phone" />
        <.input field={@form[:parent_guardian_email]} type="text" label="Parent guardian email" />
        <.input field={@form[:admission_date]} type="date" label="Admission date" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Student</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{student: student} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Students.change_student(student))
     end)}
  end

  @impl true
  def handle_event("validate", %{"student" => student_params}, socket) do
    changeset = Students.change_student(socket.assigns.student, student_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"student" => student_params}, socket) do
    save_student(socket, socket.assigns.action, student_params)
  end

  defp save_student(socket, :edit, student_params) do
    case Students.update_student(socket.assigns.student, student_params) do
      {:ok, student} ->
        notify_parent({:saved, student})

        {:noreply,
         socket
         |> put_flash(:info, "Student updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_student(socket, :new, student_params) do
    case Students.create_student(student_params) do
      {:ok, student} ->
        notify_parent({:saved, student})

        {:noreply,
         socket
         |> put_flash(:info, "Student created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
