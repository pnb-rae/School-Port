defmodule LiveschoolWeb.ImprestIssueLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.ImprestIssuesFixtures

  @create_attrs %{status: "some status", balance: "120.5", amount_issued: "120.5", amount_returned: "120.5", issue_date: "2025-12-10", return_date: "2025-12-10", purpose: "some purpose"}
  @update_attrs %{status: "some updated status", balance: "456.7", amount_issued: "456.7", amount_returned: "456.7", issue_date: "2025-12-11", return_date: "2025-12-11", purpose: "some updated purpose"}
  @invalid_attrs %{status: nil, balance: nil, amount_issued: nil, amount_returned: nil, issue_date: nil, return_date: nil, purpose: nil}

  defp create_imprest_issue(_) do
    imprest_issue = imprest_issue_fixture()
    %{imprest_issue: imprest_issue}
  end

  describe "Index" do
    setup [:create_imprest_issue]

    test "lists all imprest_issues", %{conn: conn, imprest_issue: imprest_issue} do
      {:ok, _index_live, html} = live(conn, ~p"/imprest_issues")

      assert html =~ "Listing Imprest issues"
      assert html =~ imprest_issue.status
    end

    test "saves new imprest_issue", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/imprest_issues")

      assert index_live |> element("a", "New Imprest issue") |> render_click() =~
               "New Imprest issue"

      assert_patch(index_live, ~p"/imprest_issues/new")

      assert index_live
             |> form("#imprest_issue-form", imprest_issue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#imprest_issue-form", imprest_issue: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/imprest_issues")

      html = render(index_live)
      assert html =~ "Imprest issue created successfully"
      assert html =~ "some status"
    end

    test "updates imprest_issue in listing", %{conn: conn, imprest_issue: imprest_issue} do
      {:ok, index_live, _html} = live(conn, ~p"/imprest_issues")

      assert index_live |> element("#imprest_issues-#{imprest_issue.id} a", "Edit") |> render_click() =~
               "Edit Imprest issue"

      assert_patch(index_live, ~p"/imprest_issues/#{imprest_issue}/edit")

      assert index_live
             |> form("#imprest_issue-form", imprest_issue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#imprest_issue-form", imprest_issue: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/imprest_issues")

      html = render(index_live)
      assert html =~ "Imprest issue updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes imprest_issue in listing", %{conn: conn, imprest_issue: imprest_issue} do
      {:ok, index_live, _html} = live(conn, ~p"/imprest_issues")

      assert index_live |> element("#imprest_issues-#{imprest_issue.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#imprest_issues-#{imprest_issue.id}")
    end
  end

  describe "Show" do
    setup [:create_imprest_issue]

    test "displays imprest_issue", %{conn: conn, imprest_issue: imprest_issue} do
      {:ok, _show_live, html} = live(conn, ~p"/imprest_issues/#{imprest_issue}")

      assert html =~ "Show Imprest issue"
      assert html =~ imprest_issue.status
    end

    test "updates imprest_issue within modal", %{conn: conn, imprest_issue: imprest_issue} do
      {:ok, show_live, _html} = live(conn, ~p"/imprest_issues/#{imprest_issue}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Imprest issue"

      assert_patch(show_live, ~p"/imprest_issues/#{imprest_issue}/show/edit")

      assert show_live
             |> form("#imprest_issue-form", imprest_issue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#imprest_issue-form", imprest_issue: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/imprest_issues/#{imprest_issue}")

      html = render(show_live)
      assert html =~ "Imprest issue updated successfully"
      assert html =~ "some updated status"
    end
  end
end
