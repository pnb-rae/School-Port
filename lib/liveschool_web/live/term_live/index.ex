defmodule LiveschoolWeb.TermLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.Terms
  alias Liveschool.Terms.Term

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :terms, Terms.list_terms())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Term")
    |> assign(:term, Terms.get_term!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Term")
    |> assign(:term, %Term{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Terms")
    |> assign(:term, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.TermLive.FormComponent, {:saved, term}}, socket) do
    {:noreply, stream_insert(socket, :terms, term)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    term = Terms.get_term!(id)
    {:ok, _} = Terms.delete_term(term)

    {:noreply, stream_delete(socket, :terms, term)}
  end
end
