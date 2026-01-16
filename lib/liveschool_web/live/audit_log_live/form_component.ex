defmodule LiveschoolWeb.AuditLogLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.AuditLogs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage audit_log records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="audit_log-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:action]} type="text" label="Action" />
        <.input field={@form[:table_name]} type="text" label="Table name" />
        <.input field={@form[:record_id]} type="number" label="Record" />
        <.input field={@form[:ip_address]} type="text" label="Ip address" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Audit log</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{audit_log: audit_log} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(AuditLogs.change_audit_log(audit_log))
     end)}
  end

  @impl true
  def handle_event("validate", %{"audit_log" => audit_log_params}, socket) do
    changeset = AuditLogs.change_audit_log(socket.assigns.audit_log, audit_log_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"audit_log" => audit_log_params}, socket) do
    save_audit_log(socket, socket.assigns.action, audit_log_params)
  end

  defp save_audit_log(socket, :edit, audit_log_params) do
    case AuditLogs.update_audit_log(socket.assigns.audit_log, audit_log_params) do
      {:ok, audit_log} ->
        notify_parent({:saved, audit_log})

        {:noreply,
         socket
         |> put_flash(:info, "Audit log updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_audit_log(socket, :new, audit_log_params) do
    case AuditLogs.create_audit_log(audit_log_params) do
      {:ok, audit_log} ->
        notify_parent({:saved, audit_log})

        {:noreply,
         socket
         |> put_flash(:info, "Audit log created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
