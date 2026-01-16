defmodule LiveschoolWeb.VoteHeadLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.VoteHeads

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:vote_head, VoteHeads.get_vote_head!(id))}
  end

  defp page_title(:show), do: "Show Vote head"
  defp page_title(:edit), do: "Edit Vote head"
end
