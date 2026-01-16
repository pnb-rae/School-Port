defmodule LiveschoolWeb.AuditLogLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.AuditLogsFixtures

  @create_attrs %{action: "some action", table_name: "some table_name", record_id: 42, old_values: %{}, new_values: %{}, ip_address: "some ip_address"}
  @update_attrs %{action: "some updated action", table_name: "some updated table_name", record_id: 43, old_values: %{}, new_values: %{}, ip_address: "some updated ip_address"}
  @invalid_attrs %{action: nil, table_name: nil, record_id: nil, old_values: nil, new_values: nil, ip_address: nil}

  defp create_audit_log(_) do
    audit_log = audit_log_fixture()
    %{audit_log: audit_log}
  end

  describe "Index" do
    setup [:create_audit_log]

    test "lists all audit_logs", %{conn: conn, audit_log: audit_log} do
      {:ok, _index_live, html} = live(conn, ~p"/audit_logs")

      assert html =~ "Listing Audit logs"
      assert html =~ audit_log.action
    end

    test "saves new audit_log", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/audit_logs")

      assert index_live |> element("a", "New Audit log") |> render_click() =~
               "New Audit log"

      assert_patch(index_live, ~p"/audit_logs/new")

      assert index_live
             |> form("#audit_log-form", audit_log: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#audit_log-form", audit_log: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/audit_logs")

      html = render(index_live)
      assert html =~ "Audit log created successfully"
      assert html =~ "some action"
    end

    test "updates audit_log in listing", %{conn: conn, audit_log: audit_log} do
      {:ok, index_live, _html} = live(conn, ~p"/audit_logs")

      assert index_live |> element("#audit_logs-#{audit_log.id} a", "Edit") |> render_click() =~
               "Edit Audit log"

      assert_patch(index_live, ~p"/audit_logs/#{audit_log}/edit")

      assert index_live
             |> form("#audit_log-form", audit_log: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#audit_log-form", audit_log: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/audit_logs")

      html = render(index_live)
      assert html =~ "Audit log updated successfully"
      assert html =~ "some updated action"
    end

    test "deletes audit_log in listing", %{conn: conn, audit_log: audit_log} do
      {:ok, index_live, _html} = live(conn, ~p"/audit_logs")

      assert index_live |> element("#audit_logs-#{audit_log.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#audit_logs-#{audit_log.id}")
    end
  end

  describe "Show" do
    setup [:create_audit_log]

    test "displays audit_log", %{conn: conn, audit_log: audit_log} do
      {:ok, _show_live, html} = live(conn, ~p"/audit_logs/#{audit_log}")

      assert html =~ "Show Audit log"
      assert html =~ audit_log.action
    end

    test "updates audit_log within modal", %{conn: conn, audit_log: audit_log} do
      {:ok, show_live, _html} = live(conn, ~p"/audit_logs/#{audit_log}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Audit log"

      assert_patch(show_live, ~p"/audit_logs/#{audit_log}/show/edit")

      assert show_live
             |> form("#audit_log-form", audit_log: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#audit_log-form", audit_log: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/audit_logs/#{audit_log}")

      html = render(show_live)
      assert html =~ "Audit log updated successfully"
      assert html =~ "some updated action"
    end
  end
end
