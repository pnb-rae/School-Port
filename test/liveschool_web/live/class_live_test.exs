defmodule LiveschoolWeb.ClassLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.ClassesFixtures

  @create_attrs %{name: "some name", level: 42, capacity: 42, academic_year: "some academic_year"}
  @update_attrs %{name: "some updated name", level: 43, capacity: 43, academic_year: "some updated academic_year"}
  @invalid_attrs %{name: nil, level: nil, capacity: nil, academic_year: nil}

  defp create_class(_) do
    class = class_fixture()
    %{class: class}
  end

  describe "Index" do
    setup [:create_class]

    test "lists all classes", %{conn: conn, class: class} do
      {:ok, _index_live, html} = live(conn, ~p"/classes")

      assert html =~ "Listing Classes"
      assert html =~ class.name
    end

    test "saves new class", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/classes")

      assert index_live |> element("a", "New Class") |> render_click() =~
               "New Class"

      assert_patch(index_live, ~p"/classes/new")

      assert index_live
             |> form("#class-form", class: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#class-form", class: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/classes")

      html = render(index_live)
      assert html =~ "Class created successfully"
      assert html =~ "some name"
    end

    test "updates class in listing", %{conn: conn, class: class} do
      {:ok, index_live, _html} = live(conn, ~p"/classes")

      assert index_live |> element("#classes-#{class.id} a", "Edit") |> render_click() =~
               "Edit Class"

      assert_patch(index_live, ~p"/classes/#{class}/edit")

      assert index_live
             |> form("#class-form", class: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#class-form", class: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/classes")

      html = render(index_live)
      assert html =~ "Class updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes class in listing", %{conn: conn, class: class} do
      {:ok, index_live, _html} = live(conn, ~p"/classes")

      assert index_live |> element("#classes-#{class.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#classes-#{class.id}")
    end
  end

  describe "Show" do
    setup [:create_class]

    test "displays class", %{conn: conn, class: class} do
      {:ok, _show_live, html} = live(conn, ~p"/classes/#{class}")

      assert html =~ "Show Class"
      assert html =~ class.name
    end

    test "updates class within modal", %{conn: conn, class: class} do
      {:ok, show_live, _html} = live(conn, ~p"/classes/#{class}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Class"

      assert_patch(show_live, ~p"/classes/#{class}/show/edit")

      assert show_live
             |> form("#class-form", class: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#class-form", class: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/classes/#{class}")

      html = render(show_live)
      assert html =~ "Class updated successfully"
      assert html =~ "some updated name"
    end
  end
end
