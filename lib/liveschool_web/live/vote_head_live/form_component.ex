defmodule LiveschoolWeb.VoteHeadLive.FormComponent do
  use LiveschoolWeb, :live_component

  alias Liveschool.VoteHeads

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage vote_head records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="vote_head-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:code]} type="text" label="Code" />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:budget_amount]} type="number" label="Budget amount" step="any" />
        <.input field={@form[:spent_amount]} type="number" label="Spent amount" step="any" />
        <.input field={@form[:academic_year]} type="text" label="Academic year" />
        <.input field={@form[:is_active]} type="checkbox" label="Is active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Vote head</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{vote_head: vote_head} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(VoteHeads.change_vote_head(vote_head))
     end)}
  end

  @impl true
  def handle_event("validate", %{"vote_head" => vote_head_params}, socket) do
    changeset = VoteHeads.change_vote_head(socket.assigns.vote_head, vote_head_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"vote_head" => vote_head_params}, socket) do
    save_vote_head(socket, socket.assigns.action, vote_head_params)
  end

  defp save_vote_head(socket, :edit, vote_head_params) do
    case VoteHeads.update_vote_head(socket.assigns.vote_head, vote_head_params) do
      {:ok, vote_head} ->
        notify_parent({:saved, vote_head})

        {:noreply,
         socket
         |> put_flash(:info, "Vote head updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_vote_head(socket, :new, vote_head_params) do
    case VoteHeads.create_vote_head(vote_head_params) do
      {:ok, vote_head} ->
        notify_parent({:saved, vote_head})

        {:noreply,
         socket
         |> put_flash(:info, "Vote head created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
