defmodule LiveschoolWeb.BankTransactionLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.BankTransactions

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage bank_transaction records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bank_transaction-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:transaction_type]} type="text" label="Transaction type" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:transaction_date]} type="date" label="Transaction date" />
        <.input field={@form[:reference_number]} type="text" label="Reference number" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:related_record_id]} type="number" label="Related record" />
        <.input field={@form[:related_record_type]} type="text" label="Related record type" />
        <.input field={@form[:balance_after]} type="number" label="Balance after" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bank transaction</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bank_transaction: bank_transaction} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BankTransactions.change_bank_transaction(bank_transaction))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bank_transaction" => bank_transaction_params}, socket) do
    changeset = BankTransactions.change_bank_transaction(socket.assigns.bank_transaction, bank_transaction_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bank_transaction" => bank_transaction_params}, socket) do
    save_bank_transaction(socket, socket.assigns.action, bank_transaction_params)
  end

  defp save_bank_transaction(socket, :edit, bank_transaction_params) do
    case BankTransactions.update_bank_transaction(socket.assigns.bank_transaction, bank_transaction_params) do
      {:ok, bank_transaction} ->
        notify_parent({:saved, bank_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Bank transaction updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bank_transaction(socket, :new, bank_transaction_params) do
    case BankTransactions.create_bank_transaction(bank_transaction_params) do
      {:ok, bank_transaction} ->
        notify_parent({:saved, bank_transaction})

        {:noreply,
         socket
         |> put_flash(:info, "Bank transaction created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
