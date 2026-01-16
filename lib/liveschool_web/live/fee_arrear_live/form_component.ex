defmodule LiveschoolWeb.FeeArrearLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.FeeArrears

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage fee_arrear records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="fee_arrear-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:term]} type="text" label="Term" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Fee arrear</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{fee_arrear: fee_arrear} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FeeArrears.change_fee_arrear(fee_arrear))
     end)}
  end

  @impl true
  def handle_event("validate", %{"fee_arrear" => fee_arrear_params}, socket) do
    changeset = FeeArrears.change_fee_arrear(socket.assigns.fee_arrear, fee_arrear_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"fee_arrear" => fee_arrear_params}, socket) do
    save_fee_arrear(socket, socket.assigns.action, fee_arrear_params)
  end

  defp save_fee_arrear(socket, :edit, fee_arrear_params) do
    case FeeArrears.update_fee_arrear(socket.assigns.fee_arrear, fee_arrear_params) do
      {:ok, fee_arrear} ->
        notify_parent({:saved, fee_arrear})

        {:noreply,
         socket
         |> put_flash(:info, "Fee arrear updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_fee_arrear(socket, :new, fee_arrear_params) do
    case FeeArrears.create_fee_arrear(fee_arrear_params) do
      {:ok, fee_arrear} ->
        notify_parent({:saved, fee_arrear})

        {:noreply,
         socket
         |> put_flash(:info, "Fee arrear created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
