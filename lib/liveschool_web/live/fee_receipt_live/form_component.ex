defmodule LiveschoolWeb.FeeReceiptLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.FeeReceipts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage fee_receipt records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="fee_receipt-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:receipt_number]} type="text" label="Receipt number" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:payment_method]} type="text" label="Payment method" />
        <.input field={@form[:transaction_reference]} type="text" label="Transaction reference" />
        <.input field={@form[:payment_date]} type="date" label="Payment date" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:term]} type="text" label="Term" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Fee receipt</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{fee_receipt: fee_receipt} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FeeReceipts.change_fee_receipt(fee_receipt))
     end)}
  end

  @impl true
  def handle_event("validate", %{"fee_receipt" => fee_receipt_params}, socket) do
    changeset = FeeReceipts.change_fee_receipt(socket.assigns.fee_receipt, fee_receipt_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"fee_receipt" => fee_receipt_params}, socket) do
    save_fee_receipt(socket, socket.assigns.action, fee_receipt_params)
  end

  defp save_fee_receipt(socket, :edit, fee_receipt_params) do
    case FeeReceipts.update_fee_receipt(socket.assigns.fee_receipt, fee_receipt_params) do
      {:ok, fee_receipt} ->
        notify_parent({:saved, fee_receipt})

        {:noreply,
         socket
         |> put_flash(:info, "Fee receipt updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_fee_receipt(socket, :new, fee_receipt_params) do
    case FeeReceipts.create_fee_receipt(fee_receipt_params) do
      {:ok, fee_receipt} ->
        notify_parent({:saved, fee_receipt})

        {:noreply,
         socket
         |> put_flash(:info, "Fee receipt created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
