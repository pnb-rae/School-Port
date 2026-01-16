defmodule LiveschoolWeb.FeeWaiverLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.FeeWaivers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage fee_waiver records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="fee_waiver-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:waiver_type]} type="text" label="Waiver type" />
        <.input field={@form[:amount_or_percentage]} type="number" label="Amount or percentage" step="any" />
        <.input field={@form[:reason]} type="text" label="Reason" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:term]} type="text" label="Term" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Fee waiver</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{fee_waiver: fee_waiver} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FeeWaivers.change_fee_waiver(fee_waiver))
     end)}
  end

  @impl true
  def handle_event("validate", %{"fee_waiver" => fee_waiver_params}, socket) do
    changeset = FeeWaivers.change_fee_waiver(socket.assigns.fee_waiver, fee_waiver_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"fee_waiver" => fee_waiver_params}, socket) do
    save_fee_waiver(socket, socket.assigns.action, fee_waiver_params)
  end

  defp save_fee_waiver(socket, :edit, fee_waiver_params) do
    case FeeWaivers.update_fee_waiver(socket.assigns.fee_waiver, fee_waiver_params) do
      {:ok, fee_waiver} ->
        notify_parent({:saved, fee_waiver})

        {:noreply,
         socket
         |> put_flash(:info, "Fee waiver updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_fee_waiver(socket, :new, fee_waiver_params) do
    case FeeWaivers.create_fee_waiver(fee_waiver_params) do
      {:ok, fee_waiver} ->
        notify_parent({:saved, fee_waiver})

        {:noreply,
         socket
         |> put_flash(:info, "Fee waiver created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
