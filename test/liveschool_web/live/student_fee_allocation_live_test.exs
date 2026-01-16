defmodule LiveschoolWeb.StudentFeeAllocationLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.StudentFeeAllocationsFixtures

  @create_attrs %{status: "some status", term: "some term", balance: "120.5", amount_due: "120.5", amount_paid: "120.5", due_date: "2025-12-10", academic_year: "some academic_year"}
  @update_attrs %{status: "some updated status", term: "some updated term", balance: "456.7", amount_due: "456.7", amount_paid: "456.7", due_date: "2025-12-11", academic_year: "some updated academic_year"}
  @invalid_attrs %{status: nil, term: nil, balance: nil, amount_due: nil, amount_paid: nil, due_date: nil, academic_year: nil}

  defp create_student_fee_allocation(_) do
    student_fee_allocation = student_fee_allocation_fixture()
    %{student_fee_allocation: student_fee_allocation}
  end

  describe "Index" do
    setup [:create_student_fee_allocation]

    test "lists all student_fee_allocations", %{conn: conn, student_fee_allocation: student_fee_allocation} do
      {:ok, _index_live, html} = live(conn, ~p"/student_fee_allocations")

      assert html =~ "Listing Student fee allocations"
      assert html =~ student_fee_allocation.status
    end

    test "saves new student_fee_allocation", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/student_fee_allocations")

      assert index_live |> element("a", "New Student fee allocation") |> render_click() =~
               "New Student fee allocation"

      assert_patch(index_live, ~p"/student_fee_allocations/new")

      assert index_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/student_fee_allocations")

      html = render(index_live)
      assert html =~ "Student fee allocation created successfully"
      assert html =~ "some status"
    end

    test "updates student_fee_allocation in listing", %{conn: conn, student_fee_allocation: student_fee_allocation} do
      {:ok, index_live, _html} = live(conn, ~p"/student_fee_allocations")

      assert index_live |> element("#student_fee_allocations-#{student_fee_allocation.id} a", "Edit") |> render_click() =~
               "Edit Student fee allocation"

      assert_patch(index_live, ~p"/student_fee_allocations/#{student_fee_allocation}/edit")

      assert index_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/student_fee_allocations")

      html = render(index_live)
      assert html =~ "Student fee allocation updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes student_fee_allocation in listing", %{conn: conn, student_fee_allocation: student_fee_allocation} do
      {:ok, index_live, _html} = live(conn, ~p"/student_fee_allocations")

      assert index_live |> element("#student_fee_allocations-#{student_fee_allocation.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#student_fee_allocations-#{student_fee_allocation.id}")
    end
  end

  describe "Show" do
    setup [:create_student_fee_allocation]

    test "displays student_fee_allocation", %{conn: conn, student_fee_allocation: student_fee_allocation} do
      {:ok, _show_live, html} = live(conn, ~p"/student_fee_allocations/#{student_fee_allocation}")

      assert html =~ "Show Student fee allocation"
      assert html =~ student_fee_allocation.status
    end

    test "updates student_fee_allocation within modal", %{conn: conn, student_fee_allocation: student_fee_allocation} do
      {:ok, show_live, _html} = live(conn, ~p"/student_fee_allocations/#{student_fee_allocation}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Student fee allocation"

      assert_patch(show_live, ~p"/student_fee_allocations/#{student_fee_allocation}/show/edit")

      assert show_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#student_fee_allocation-form", student_fee_allocation: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/student_fee_allocations/#{student_fee_allocation}")

      html = render(show_live)
      assert html =~ "Student fee allocation updated successfully"
      assert html =~ "some updated status"
    end
  end
end
