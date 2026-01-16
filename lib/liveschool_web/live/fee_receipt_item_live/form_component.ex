defmodule LiveschoolWeb.FeeReceiptItemLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.FeeReceiptItems

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage fee_receipt_item records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="fee_receipt_item-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Fee receipt item</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{fee_receipt_item: fee_receipt_item} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(FeeReceiptItems.change_fee_receipt_item(fee_receipt_item))
     end)}
  end

  @impl true
  def handle_event("validate", %{"fee_receipt_item" => fee_receipt_item_params}, socket) do
    changeset = FeeReceiptItems.change_fee_receipt_item(socket.assigns.fee_receipt_item, fee_receipt_item_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"fee_receipt_item" => fee_receipt_item_params}, socket) do
    save_fee_receipt_item(socket, socket.assigns.action, fee_receipt_item_params)
  end

  defp save_fee_receipt_item(socket, :edit, fee_receipt_item_params) do
    case FeeReceiptItems.update_fee_receipt_item(socket.assigns.fee_receipt_item, fee_receipt_item_params) do
      {:ok, fee_receipt_item} ->
        notify_parent({:saved, fee_receipt_item})

        {:noreply,
         socket
         |> put_flash(:info, "Fee receipt item updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_fee_receipt_item(socket, :new, fee_receipt_item_params) do
    case FeeReceiptItems.create_fee_receipt_item(fee_receipt_item_params) do
      {:ok, fee_receipt_item} ->
        notify_parent({:saved, fee_receipt_item})

        {:noreply,
         socket
         |> put_flash(:info, "Fee receipt item created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
