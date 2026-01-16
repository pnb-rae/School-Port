defmodule LiveschoolWeb.StaffMemberLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.StaffFixtures

  @create_attrs %{position: "some position", status: "some status", staff_number: "some staff_number", first_name: "some first_name", last_name: "some last_name", phone: "some phone", email: "some email", date_of_birth: "2025-12-10", hire_date: "2025-12-10", salary: "120.5", account_number: "some account_number"}
  @update_attrs %{position: "some updated position", status: "some updated status", staff_number: "some updated staff_number", first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", email: "some updated email", date_of_birth: "2025-12-11", hire_date: "2025-12-11", salary: "456.7", account_number: "some updated account_number"}
  @invalid_attrs %{position: nil, status: nil, staff_number: nil, first_name: nil, last_name: nil, phone: nil, email: nil, date_of_birth: nil, hire_date: nil, salary: nil, account_number: nil}

  defp create_staff_member(_) do
    staff_member = staff_member_fixture()
    %{staff_member: staff_member}
  end

  describe "Index" do
    setup [:create_staff_member]

    test "lists all staff_members", %{conn: conn, staff_member: staff_member} do
      {:ok, _index_live, html} = live(conn, ~p"/staff_members")

      assert html =~ "Listing Staff members"
      assert html =~ staff_member.position
    end

    test "saves new staff_member", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/staff_members")

      assert index_live |> element("a", "New Staff member") |> render_click() =~
               "New Staff member"

      assert_patch(index_live, ~p"/staff_members/new")

      assert index_live
             |> form("#staff_member-form", staff_member: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#staff_member-form", staff_member: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/staff_members")

      html = render(index_live)
      assert html =~ "Staff member created successfully"
      assert html =~ "some position"
    end

    test "updates staff_member in listing", %{conn: conn, staff_member: staff_member} do
      {:ok, index_live, _html} = live(conn, ~p"/staff_members")

      assert index_live |> element("#staff_members-#{staff_member.id} a", "Edit") |> render_click() =~
               "Edit Staff member"

      assert_patch(index_live, ~p"/staff_members/#{staff_member}/edit")

      assert index_live
             |> form("#staff_member-form", staff_member: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#staff_member-form", staff_member: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/staff_members")

      html = render(index_live)
      assert html =~ "Staff member updated successfully"
      assert html =~ "some updated position"
    end

    test "deletes staff_member in listing", %{conn: conn, staff_member: staff_member} do
      {:ok, index_live, _html} = live(conn, ~p"/staff_members")

      assert index_live |> element("#staff_members-#{staff_member.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#staff_members-#{staff_member.id}")
    end
  end

  describe "Show" do
    setup [:create_staff_member]

    test "displays staff_member", %{conn: conn, staff_member: staff_member} do
      {:ok, _show_live, html} = live(conn, ~p"/staff_members/#{staff_member}")

      assert html =~ "Show Staff member"
      assert html =~ staff_member.position
    end

    test "updates staff_member within modal", %{conn: conn, staff_member: staff_member} do
      {:ok, show_live, _html} = live(conn, ~p"/staff_members/#{staff_member}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Staff member"

      assert_patch(show_live, ~p"/staff_members/#{staff_member}/show/edit")

      assert show_live
             |> form("#staff_member-form", staff_member: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#staff_member-form", staff_member: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/staff_members/#{staff_member}")

      html = render(show_live)
      assert html =~ "Staff member updated successfully"
      assert html =~ "some updated position"
    end
  end
end
