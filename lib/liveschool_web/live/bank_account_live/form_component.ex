defmodule LiveschoolWeb.BankAccountLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.BankAccounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage bank_account records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bank_account-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:branch]} type="text" label="Branch" />
        <.input field={@form[:account_number]} type="text" label="Account number" />
        <.input field={@form[:account_name]} type="text" label="Account name" />
        <.input field={@form[:current_balance]} type="number" label="Current balance" step="any" />
        <.input field={@form[:opening_balance]} type="number" label="Opening balance" step="any" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bank account</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bank_account: bank_account} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(BankAccounts.change_bank_account(bank_account))
     end)}
  end

  @impl true
  def handle_event("validate", %{"bank_account" => bank_account_params}, socket) do
    changeset = BankAccounts.change_bank_account(socket.assigns.bank_account, bank_account_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"bank_account" => bank_account_params}, socket) do
    save_bank_account(socket, socket.assigns.action, bank_account_params)
  end

  defp save_bank_account(socket, :edit, bank_account_params) do
    case BankAccounts.update_bank_account(socket.assigns.bank_account, bank_account_params) do
      {:ok, bank_account} ->
        notify_parent({:saved, bank_account})

        {:noreply,
         socket
         |> put_flash(:info, "Bank account updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_bank_account(socket, :new, bank_account_params) do
    case BankAccounts.create_bank_account(bank_account_params) do
      {:ok, bank_account} ->
        notify_parent({:saved, bank_account})

        {:noreply,
         socket
         |> put_flash(:info, "Bank account created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
