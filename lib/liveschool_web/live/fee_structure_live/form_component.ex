defmodule LiveschoolWeb.FeeStructureLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.FeeStructures

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage fee_structure records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="fee_structure-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:fee_type]} type="text" label="Fee type" />
        <.input field={@form[:payment_frequency]} type="text" label="Payment frequency" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:term]} type="text" label="Term" />
        <.input field={@form[:is_mandatory]} type="checkbox" label="Is mandatory" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Fee structure</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{fee_structure: fee_structure} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FeeStructures.change_fee_structure(fee_structure))
     end)}
  end

  @impl true
  def handle_event("validate", %{"fee_structure" => fee_structure_params}, socket) do
    changeset = FeeStructures.change_fee_structure(socket.assigns.fee_structure, fee_structure_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"fee_structure" => fee_structure_params}, socket) do
    save_fee_structure(socket, socket.assigns.action, fee_structure_params)
  end

  defp save_fee_structure(socket, :edit, fee_structure_params) do
    case FeeStructures.update_fee_structure(socket.assigns.fee_structure, fee_structure_params) do
      {:ok, fee_structure} ->
        notify_parent({:saved, fee_structure})

        {:noreply,
         socket
         |> put_flash(:info, "Fee structure updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_fee_structure(socket, :new, fee_structure_params) do
    case FeeStructures.create_fee_structure(fee_structure_params) do
      {:ok, fee_structure} ->
        notify_parent({:saved, fee_structure})

        {:noreply,
         socket
         |> put_flash(:info, "Fee structure created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
