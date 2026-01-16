defmodule LiveschoolWeb.ClassLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Classes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage class records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="class-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:level]} type="number" label="Level" />
        <.input field={@form[:capacity]} type="number" label="Capacity" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Class</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{class: class} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Classes.change_class(class))
     end)}
  end

  @impl true
  def handle_event("validate", %{"class" => class_params}, socket) do
    changeset = Classes.change_class(socket.assigns.class, class_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"class" => class_params}, socket) do
    save_class(socket, socket.assigns.action, class_params)
  end

  defp save_class(socket, :edit, class_params) do
    case Classes.update_class(socket.assigns.class, class_params) do
      {:ok, class} ->
        notify_parent({:saved, class})

        {:noreply,
         socket
         |> put_flash(:info, "Class updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_class(socket, :new, class_params) do
    case Classes.create_class(class_params) do
      {:ok, class} ->
        notify_parent({:saved, class})

        {:noreply,
         socket
         |> put_flash(:info, "Class created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
