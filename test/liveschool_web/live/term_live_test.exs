defmodule LiveschoolWeb.TermLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.TermsFixtures

  @create_attrs %{name: "some name", academic_year: "some academic_year", start_date: "2025-12-10", end_date: "2025-12-10", is_current: true}
  @update_attrs %{name: "some updated name", academic_year: "some updated academic_year", start_date: "2025-12-11", end_date: "2025-12-11", is_current: false}
  @invalid_attrs %{name: nil, academic_year: nil, start_date: nil, end_date: nil, is_current: false}

  defp create_term(_) do
    term = term_fixture()
    %{term: term}
  end

  describe "Index" do
    setup [:create_term]

    test "lists all terms", %{conn: conn, term: term} do
      {:ok, _index_live, html} = live(conn, ~p"/terms")

      assert html =~ "Listing Terms"
      assert html =~ term.name
    end

    test "saves new term", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/terms")

      assert index_live |> element("a", "New Term") |> render_click() =~
               "New Term"

      assert_patch(index_live, ~p"/terms/new")

      assert index_live
             |> form("#term-form", term: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#term-form", term: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/terms")

      html = render(index_live)
      assert html =~ "Term created successfully"
      assert html =~ "some name"
    end

    test "updates term in listing", %{conn: conn, term: term} do
      {:ok, index_live, _html} = live(conn, ~p"/terms")

      assert index_live |> element("#terms-#{term.id} a", "Edit") |> render_click() =~
               "Edit Term"

      assert_patch(index_live, ~p"/terms/#{term}/edit")

      assert index_live
             |> form("#term-form", term: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#term-form", term: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/terms")

      html = render(index_live)
      assert html =~ "Term updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes term in listing", %{conn: conn, term: term} do
      {:ok, index_live, _html} = live(conn, ~p"/terms")

      assert index_live |> element("#terms-#{term.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#terms-#{term.id}")
    end
  end

  describe "Show" do
    setup [:create_term]

    test "displays term", %{conn: conn, term: term} do
      {:ok, _show_live, html} = live(conn, ~p"/terms/#{term}")

      assert html =~ "Show Term"
      assert html =~ term.name
    end

    test "updates term within modal", %{conn: conn, term: term} do
      {:ok, show_live, _html} = live(conn, ~p"/terms/#{term}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Term"

      assert_patch(show_live, ~p"/terms/#{term}/show/edit")

      assert show_live
             |> form("#term-form", term: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#term-form", term: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/terms/#{term}")

      html = render(show_live)
      assert html =~ "Term updated successfully"
      assert html =~ "some updated name"
    end
  end
end
