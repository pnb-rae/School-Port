defmodule LiveschoolWeb.PocketMoneyTransactionLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.PocketMoneyTransactions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage pocket_money_transaction records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pocket_money_transaction-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:transaction_type]} type="text" label="Transaction type" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:balance_after]} type="number" label="Balance after" step="any" />
        <.input field={@form[:transaction_date]} type="date" label="Transaction date" />
        <.input field={@form[:notes]} type="text" label="Notes" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pocket money transaction</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pocket_money_transaction: pocket_money_transaction} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(PocketMoneyTransactions.change_pocket_money_transaction(pocket_money_transaction))
     end)}
  end

  @impl true
  def handle_event("validate", %{"pocket_money_transaction" => pocket_money_transaction_params}, socket) do
    changeset = PocketMoneyTransactions.change_pocket_money_transaction(socket.assigns.pocket_money_transaction, pocket_money_transaction_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"pocket_money_transaction" => pocket_money_transaction_params}, socket) do
    save_pocket_money_transaction(socket, socket.assigns.action, pocket_money_transaction_params)
  end

  defp save_pocket_money_transaction(socket, :edit, pocket_money_transaction_params) do
    case PocketMoneyTransactions.update_pocket_money_transaction(socket.assigns.pocket_money_transaction, pocket_money_transaction_params) do
      {:ok, pocket_money_transaction} ->
        notify_parent({:saved, pocket_money_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Pocket money transaction updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_pocket_money_transaction(socket, :new, pocket_money_transaction_params) do
    case PocketMoneyTransactions.create_pocket_money_transaction(pocket_money_transaction_params) do
      {:ok, pocket_money_transaction} ->
        notify_parent({:saved, pocket_money_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Pocket money transaction created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
