defmodule LiveschoolWeb.SupplierLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Suppliers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage supplier records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="supplier-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:contact_person]} type="text" label="Contact person" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:kra_pin]} type="text" label="Kra pin" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Supplier</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{supplier: supplier} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Suppliers.change_supplier(supplier))
     end)}
  end

  @impl true
  def handle_event("validate", %{"supplier" => supplier_params}, socket) do
    changeset = Suppliers.change_supplier(socket.assigns.supplier, supplier_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"supplier" => supplier_params}, socket) do
    save_supplier(socket, socket.assigns.action, supplier_params)
  end

  defp save_supplier(socket, :edit, supplier_params) do
    case Suppliers.update_supplier(socket.assigns.supplier, supplier_params) do
      {:ok, supplier} ->
        notify_parent({:saved, supplier})

        {:noreply,
         socket
         |> put_flash(:info, "Supplier updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_supplier(socket, :new, supplier_params) do
    case Suppliers.create_supplier(supplier_params) do
      {:ok, supplier} ->
        notify_parent({:saved, supplier})

        {:noreply,
         socket
         |> put_flash(:info, "Supplier created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
