defmodule LiveschoolWeb.StudentLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.StudentsFixtures

  @create_attrs %{status: "some status", address: "some address", admission_number: "some admission_number", first_name: "some first_name", middle_name: "some middle_name", last_name: "some last_name", date_of_birth: "2025-12-10", gender: "some gender", photo_url: "some photo_url", parent_guardian_name: "some parent_guardian_name", parent_guardian_phone: "some parent_guardian_phone", parent_guardian_email: "some parent_guardian_email", admission_date: "2025-12-10"}
  @update_attrs %{status: "some updated status", address: "some updated address", admission_number: "some updated admission_number", first_name: "some updated first_name", middle_name: "some updated middle_name", last_name: "some updated last_name", date_of_birth: "2025-12-11", gender: "some updated gender", photo_url: "some updated photo_url", parent_guardian_name: "some updated parent_guardian_name", parent_guardian_phone: "some updated parent_guardian_phone", parent_guardian_email: "some updated parent_guardian_email", admission_date: "2025-12-11"}
  @invalid_attrs %{status: nil, address: nil, admission_number: nil, first_name: nil, middle_name: nil, last_name: nil, date_of_birth: nil, gender: nil, photo_url: nil, parent_guardian_name: nil, parent_guardian_phone: nil, parent_guardian_email: nil, admission_date: nil}

  defp create_student(_) do
    student = student_fixture()
    %{student: student}
  end

  describe "Index" do
    setup [:create_student]

    test "lists all students", %{conn: conn, student: student} do
      {:ok, _index_live, html} = live(conn, ~p"/students")

      assert html =~ "Listing Students"
      assert html =~ student.status
    end

    test "saves new student", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("a", "New Student") |> render_click() =~
               "New Student"

      assert_patch(index_live, ~p"/students/new")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Student created successfully"
      assert html =~ "some status"
    end

    test "updates student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{student.id} a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(index_live, ~p"/students/#{student}/edit")

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/students")

      html = render(index_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, ~p"/students")

      assert index_live |> element("#students-#{student.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#students-#{student.id}")
    end
  end

  describe "Show" do
    setup [:create_student]

    test "displays student", %{conn: conn, student: student} do
      {:ok, _show_live, html} = live(conn, ~p"/students/#{student}")

      assert html =~ "Show Student"
      assert html =~ student.status
    end

    test "updates student within modal", %{conn: conn, student: student} do
      {:ok, show_live, _html} = live(conn, ~p"/students/#{student}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(show_live, ~p"/students/#{student}/show/edit")

      assert show_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#student-form", student: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/students/#{student}")

      html = render(show_live)
      assert html =~ "Student updated successfully"
      assert html =~ "some updated status"
    end
  end
end
