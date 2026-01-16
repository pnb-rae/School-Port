defmodule LiveschoolWeb.TermLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.Terms

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage term records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="term-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:start_date]} type="date" label="Start date" />
        <.input field={@form[:end_date]} type="date" label="End date" />
        <.input field={@form[:is_current]} type="checkbox" label="Is current" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Term</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{term: term} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Terms.change_term(term))
     end)}
  end

  @impl true
  def handle_event("validate", %{"term" => term_params}, socket) do
    changeset = Terms.change_term(socket.assigns.term, term_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"term" => term_params}, socket) do
    save_term(socket, socket.assigns.action, term_params)
  end

  defp save_term(socket, :edit, term_params) do
    case Terms.update_term(socket.assigns.term, term_params) do
      {:ok, term} ->
        notify_parent({:saved, term})

        {:noreply,
         socket
         |> put_flash(:info, "Term updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_term(socket, :new, term_params) do
    case Terms.create_term(term_params) do
      {:ok, term} ->
        notify_parent({:saved, term})

        {:noreply,
         socket
         |> put_flash(:info, "Term created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
