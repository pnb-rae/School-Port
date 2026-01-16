defmodule LiveschoolWeb.FeeStructureLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.FeeStructuresFixtures

  @create_attrs %{name: "some name", term: "some term", amount: "120.5", fee_type: "some fee_type", payment_frequency: "some payment_frequency", academic_year: "some academic_year", is_mandatory: true}
  @update_attrs %{name: "some updated name", term: "some updated term", amount: "456.7", fee_type: "some updated fee_type", payment_frequency: "some updated payment_frequency", academic_year: "some updated academic_year", is_mandatory: false}
  @invalid_attrs %{name: nil, term: nil, amount: nil, fee_type: nil, payment_frequency: nil, academic_year: nil, is_mandatory: false}

  defp create_fee_structure(_) do
    fee_structure = fee_structure_fixture()
    %{fee_structure: fee_structure}
  end

  describe "Index" do
    setup [:create_fee_structure]

    test "lists all fee_structures", %{conn: conn, fee_structure: fee_structure} do
      {:ok, _index_live, html} = live(conn, ~p"/fee_structures")

      assert html =~ "Listing Fee structures"
      assert html =~ fee_structure.name
    end

    test "saves new fee_structure", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_structures")

      assert index_live |> element("a", "New Fee structure") |> render_click() =~
               "New Fee structure"

      assert_patch(index_live, ~p"/fee_structures/new")

      assert index_live
             |> form("#fee_structure-form", fee_structure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_structure-form", fee_structure: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_structures")

      html = render(index_live)
      assert html =~ "Fee structure created successfully"
      assert html =~ "some name"
    end

    test "updates fee_structure in listing", %{conn: conn, fee_structure: fee_structure} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_structures")

      assert index_live |> element("#fee_structures-#{fee_structure.id} a", "Edit") |> render_click() =~
               "Edit Fee structure"

      assert_patch(index_live, ~p"/fee_structures/#{fee_structure}/edit")

      assert index_live
             |> form("#fee_structure-form", fee_structure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_structure-form", fee_structure: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_structures")

      html = render(index_live)
      assert html =~ "Fee structure updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes fee_structure in listing", %{conn: conn, fee_structure: fee_structure} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_structures")

      assert index_live |> element("#fee_structures-#{fee_structure.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fee_structures-#{fee_structure.id}")
    end
  end

  describe "Show" do
    setup [:create_fee_structure]

    test "displays fee_structure", %{conn: conn, fee_structure: fee_structure} do
      {:ok, _show_live, html} = live(conn, ~p"/fee_structures/#{fee_structure}")

      assert html =~ "Show Fee structure"
      assert html =~ fee_structure.name
    end

    test "updates fee_structure within modal", %{conn: conn, fee_structure: fee_structure} do
      {:ok, show_live, _html} = live(conn, ~p"/fee_structures/#{fee_structure}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fee structure"

      assert_patch(show_live, ~p"/fee_structures/#{fee_structure}/show/edit")

      assert show_live
             |> form("#fee_structure-form", fee_structure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#fee_structure-form", fee_structure: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fee_structures/#{fee_structure}")

      html = render(show_live)
      assert html =~ "Fee structure updated successfully"
      assert html =~ "some updated name"
    end
  end
end
