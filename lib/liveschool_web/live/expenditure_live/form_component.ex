defmodule LiveschoolWeb.ExpenditureLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Expenditures

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage expenditure records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="expenditure-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:payment_number]} type="text" label="Payment number" />
        <.input field={@form[:payee_type]} type="text" label="Payee type" />
        <.input field={@form[:payee_id]} type="number" label="Payee" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:payment_method]} type="text" label="Payment method" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:payment_date]} type="date" label="Payment date" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Expenditure</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{expenditure: expenditure} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Expenditures.change_expenditure(expenditure))
     end)}
  end

  @impl true
  def handle_event("validate", %{"expenditure" => expenditure_params}, socket) do
    changeset = Expenditures.change_expenditure(socket.assigns.expenditure, expenditure_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"expenditure" => expenditure_params}, socket) do
    save_expenditure(socket, socket.assigns.action, expenditure_params)
  end

  defp save_expenditure(socket, :edit, expenditure_params) do
    case Expenditures.update_expenditure(socket.assigns.expenditure, expenditure_params) do
      {:ok, expenditure} ->
        notify_parent({:saved, expenditure})

        {:noreply,
         socket
         |> put_flash(:info, "Expenditure updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_expenditure(socket, :new, expenditure_params) do
    case Expenditures.create_expenditure(expenditure_params) do
      {:ok, expenditure} ->
        notify_parent({:saved, expenditure})

        {:noreply,
         socket
         |> put_flash(:info, "Expenditure created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
