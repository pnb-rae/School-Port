defmodule LiveschoolWeb.SchoolLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.SchoolsFixtures

  @create_attrs %{code: "some code", name: "some name", address: "some address", phone: "some phone", email: "some email", logo_url: "some logo_url", established_date: "2025-12-10", current_academic_year: "some current_academic_year", settings: %{}}
  @update_attrs %{code: "some updated code", name: "some updated name", address: "some updated address", phone: "some updated phone", email: "some updated email", logo_url: "some updated logo_url", established_date: "2025-12-11", current_academic_year: "some updated current_academic_year", settings: %{}}
  @invalid_attrs %{code: nil, name: nil, address: nil, phone: nil, email: nil, logo_url: nil, established_date: nil, current_academic_year: nil, settings: nil}

  defp create_school(_) do
    school = school_fixture()
    %{school: school}
  end

  describe "Index" do
    setup [:create_school]

    test "lists all schools", %{conn: conn, school: school} do
      {:ok, _index_live, html} = live(conn, ~p"/schools")

      assert html =~ "Listing Schools"
      assert html =~ school.code
    end

    test "saves new school", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/schools")

      assert index_live |> element("a", "New School") |> render_click() =~
               "New School"

      assert_patch(index_live, ~p"/schools/new")

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school-form", school: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/schools")

      html = render(index_live)
      assert html =~ "School created successfully"
      assert html =~ "some code"
    end

    test "updates school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, ~p"/schools")

      assert index_live |> element("#schools-#{school.id} a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(index_live, ~p"/schools/#{school}/edit")

      assert index_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school-form", school: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/schools")

      html = render(index_live)
      assert html =~ "School updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes school in listing", %{conn: conn, school: school} do
      {:ok, index_live, _html} = live(conn, ~p"/schools")

      assert index_live |> element("#schools-#{school.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#schools-#{school.id}")
    end
  end

  describe "Show" do
    setup [:create_school]

    test "displays school", %{conn: conn, school: school} do
      {:ok, _show_live, html} = live(conn, ~p"/schools/#{school}")

      assert html =~ "Show School"
      assert html =~ school.code
    end

    test "updates school within modal", %{conn: conn, school: school} do
      {:ok, show_live, _html} = live(conn, ~p"/schools/#{school}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit School"

      assert_patch(show_live, ~p"/schools/#{school}/show/edit")

      assert show_live
             |> form("#school-form", school: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#school-form", school: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/schools/#{school}")

      html = render(show_live)
      assert html =~ "School updated successfully"
      assert html =~ "some updated code"
    end
  end
end
