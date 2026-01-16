defmodule LiveschoolWeb.ImprestIssueLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.ImprestIssues

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage imprest_issue records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="imprest_issue-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:amount_issued]} type="number" label="Amount issued" step="any" />
        <.input field={@form[:amount_returned]} type="number" label="Amount returned" step="any" />
        <.input field={@form[:balance]} type="number" label="Balance" step="any" />
        <.input field={@form[:issue_date]} type="date" label="Issue date" />
        <.input field={@form[:return_date]} type="date" label="Return date" />
        <.input field={@form[:purpose]} type="text" label="Purpose" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Imprest issue</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{imprest_issue: imprest_issue} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(ImprestIssues.change_imprest_issue(imprest_issue))
     end)}
  end

  @impl true
  def handle_event("validate", %{"imprest_issue" => imprest_issue_params}, socket) do
    changeset = ImprestIssues.change_imprest_issue(socket.assigns.imprest_issue, imprest_issue_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"imprest_issue" => imprest_issue_params}, socket) do
    save_imprest_issue(socket, socket.assigns.action, imprest_issue_params)
  end

  defp save_imprest_issue(socket, :edit, imprest_issue_params) do
    case ImprestIssues.update_imprest_issue(socket.assigns.imprest_issue, imprest_issue_params) do
      {:ok, imprest_issue} ->
        notify_parent({:saved, imprest_issue})

        {:noreply,
         socket
         |> put_flash(:info, "Imprest issue updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_imprest_issue(socket, :new, imprest_issue_params) do
    case ImprestIssues.create_imprest_issue(imprest_issue_params) do
      {:ok, imprest_issue} ->
        notify_parent({:saved, imprest_issue})

        {:noreply,
         socket
         |> put_flash(:info, "Imprest issue created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
