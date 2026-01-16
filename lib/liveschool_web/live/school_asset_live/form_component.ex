defmodule LiveschoolWeb.SchoolAssetLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.SchoolAssets

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage school_asset records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="school_asset-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:asset_number]} type="text" label="Asset number" />
        <.input field={@form[:category]} type="text" label="Category" />
        <.input field={@form[:purchase_date]} type="date" label="Purchase date" />
        <.input field={@form[:purchase_price]} type="number" label="Purchase price" step="any" />
        <.input field={@form[:current_value]} type="number" label="Current value" step="any" />
        <.input field={@form[:depreciation_rate]} type="number" label="Depreciation rate" step="any" />
        <.input field={@form[:location]} type="text" label="Location" />
        <.input field={@form[:condition]} type="text" label="Condition" />
        <:actions>
          <.button phx-disable-with="Saving...">Save School asset</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{school_asset: school_asset} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(SchoolAssets.change_school_asset(school_asset))
     end)}
  end

  @impl true
  def handle_event("validate", %{"school_asset" => school_asset_params}, socket) do
    changeset = SchoolAssets.change_school_asset(socket.assigns.school_asset, school_asset_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"school_asset" => school_asset_params}, socket) do
    save_school_asset(socket, socket.assigns.action, school_asset_params)
  end

  defp save_school_asset(socket, :edit, school_asset_params) do
    case SchoolAssets.update_school_asset(socket.assigns.school_asset, school_asset_params) do
      {:ok, school_asset} ->
        notify_parent({:saved, school_asset})

        {:noreply,
         socket
         |> put_flash(:info, "School asset updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_school_asset(socket, :new, school_asset_params) do
    case SchoolAssets.create_school_asset(school_asset_params) do
      {:ok, school_asset} ->
        notify_parent({:saved, school_asset})

        {:noreply,
         socket
         |> put_flash(:info, "School asset created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
