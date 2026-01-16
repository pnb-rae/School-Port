defmodule LiveschoolWeb.VoteHeadLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.VoteHeads
  alias Liveschool.VoteHeads.VoteHead

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vote_heads, VoteHeads.list_vote_heads())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vote head")
    |> assign(:vote_head, VoteHeads.get_vote_head!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vote head")
    |> assign(:vote_head, %VoteHead{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vote heads")
    |> assign(:vote_head, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.VoteHeadLive.FormComponent, {:saved, vote_head}}, socket) do
    {:noreply, stream_insert(socket, :vote_heads, vote_head)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vote_head = VoteHeads.get_vote_head!(id)
    {:ok, _} = VoteHeads.delete_vote_head(vote_head)

    {:noreply, stream_delete(socket, :vote_heads, vote_head)}
  end
end
