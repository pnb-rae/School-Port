defmodule LiveschoolWeb.PettyCashTransactionLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.PettyCashTransactions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage petty_cash_transaction records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="petty_cash_transaction-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:transaction_type]} type="text" label="Transaction type" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:transaction_date]} type="date" label="Transaction date" />
        <.input field={@form[:balance_after]} type="number" label="Balance after" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Petty cash transaction</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{petty_cash_transaction: petty_cash_transaction} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(PettyCashTransactions.change_petty_cash_transaction(petty_cash_transaction))
     end)}
  end

  @impl true
  def handle_event("validate", %{"petty_cash_transaction" => petty_cash_transaction_params}, socket) do
    changeset = PettyCashTransactions.change_petty_cash_transaction(socket.assigns.petty_cash_transaction, petty_cash_transaction_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"petty_cash_transaction" => petty_cash_transaction_params}, socket) do
    save_petty_cash_transaction(socket, socket.assigns.action, petty_cash_transaction_params)
  end

  defp save_petty_cash_transaction(socket, :edit, petty_cash_transaction_params) do
    case PettyCashTransactions.update_petty_cash_transaction(socket.assigns.petty_cash_transaction, petty_cash_transaction_params) do
      {:ok, petty_cash_transaction} ->
        notify_parent({:saved, petty_cash_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Petty cash transaction updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_petty_cash_transaction(socket, :new, petty_cash_transaction_params) do
    case PettyCashTransactions.create_petty_cash_transaction(petty_cash_transaction_params) do
      {:ok, petty_cash_transaction} ->
        notify_parent({:saved, petty_cash_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Petty cash transaction created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
