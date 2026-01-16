defmodule LiveschoolWeb.ImprestIssueLive.Index do
  use LiveschoolWeb, :live_view

  alias Liveschool.ImprestIssues
  alias Liveschool.ImprestIssues.ImprestIssue

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :imprest_issues, ImprestIssues.list_imprest_issues())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Imprest issue")
    |> assign(:imprest_issue, ImprestIssues.get_imprest_issue!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Imprest issue")
    |> assign(:imprest_issue, %ImprestIssue{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Imprest issues")
    |> assign(:imprest_issue, nil)
  end

  @impl true
  def handle_info({LiveschoolWeb.ImprestIssueLive.FormComponent, {:saved, imprest_issue}}, socket) do
    {:noreply, stream_insert(socket, :imprest_issues, imprest_issue)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    imprest_issue = ImprestIssues.get_imprest_issue!(id)
    {:ok, _} = ImprestIssues.delete_imprest_issue(imprest_issue)

    {:noreply, stream_delete(socket, :imprest_issues, imprest_issue)}
  end
end
