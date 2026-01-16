defmodule LiveschoolWeb.SchoolAssetLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.SchoolAssets
  alias Liveschool.SchoolAssets.SchoolAsset

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :school_assets, SchoolAssets.list_school_assets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit School asset")
    |> assign(:school_asset, SchoolAssets.get_school_asset!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New School asset")
    |> assign(:school_asset, %SchoolAsset{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing School assets")
    |> assign(:school_asset, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.SchoolAssetLive.FormComponent, {:saved, school_asset}}, socket) do
    {:noreply, stream_insert(socket, :school_assets, school_asset)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    school_asset = SchoolAssets.get_school_asset!(id)
    {:ok, _} = SchoolAssets.delete_school_asset(school_asset)

    {:noreply, stream_delete(socket, :school_assets, school_asset)}
  end
end
