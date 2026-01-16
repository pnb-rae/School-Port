defmodule LiveschoolWeb.SchoolAssetLive.Show do
  use LiveschoolWeb, :live_view

  alias Liveschool.SchoolAssets

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:school_asset, SchoolAssets.get_school_asset!(id))}
  end

  defp page_title(:show), do: "Show School asset"
  defp page_title(:edit), do: "Edit School asset"
end
