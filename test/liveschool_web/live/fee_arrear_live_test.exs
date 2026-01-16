defmodule LiveschoolWeb.FeeArrearLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.FeeArrearsFixtures

  @create_attrs %{status: "some status", term: "some term", amount: "120.5", academic_year: "some academic_year", notes: "some notes"}
  @update_attrs %{status: "some updated status", term: "some updated term", amount: "456.7", academic_year: "some updated academic_year", notes: "some updated notes"}
  @invalid_attrs %{status: nil, term: nil, amount: nil, academic_year: nil, notes: nil}

  defp create_fee_arrear(_) do
    fee_arrear = fee_arrear_fixture()
    %{fee_arrear: fee_arrear}
  end

  describe "Index" do
    setup [:create_fee_arrear]

    test "lists all fee_arrears", %{conn: conn, fee_arrear: fee_arrear} do
      {:ok, _index_live, html} = live(conn, ~p"/fee_arrears")

      assert html =~ "Listing Fee arrears"
      assert html =~ fee_arrear.status
    end

    test "saves new fee_arrear", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_arrears")

      assert index_live |> element("a", "New Fee arrear") |> render_click() =~
               "New Fee arrear"

      assert_patch(index_live, ~p"/fee_arrears/new")

      assert index_live
             |> form("#fee_arrear-form", fee_arrear: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_arrear-form", fee_arrear: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_arrears")

      html = render(index_live)
      assert html =~ "Fee arrear created successfully"
      assert html =~ "some status"
    end

    test "updates fee_arrear in listing", %{conn: conn, fee_arrear: fee_arrear} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_arrears")

      assert index_live |> element("#fee_arrears-#{fee_arrear.id} a", "Edit") |> render_click() =~
               "Edit Fee arrear"

      assert_patch(index_live, ~p"/fee_arrears/#{fee_arrear}/edit")

      assert index_live
             |> form("#fee_arrear-form", fee_arrear: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_arrear-form", fee_arrear: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_arrears")

      html = render(index_live)
      assert html =~ "Fee arrear updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes fee_arrear in listing", %{conn: conn, fee_arrear: fee_arrear} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_arrears")

      assert index_live |> element("#fee_arrears-#{fee_arrear.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fee_arrears-#{fee_arrear.id}")
    end
  end

  describe "Show" do
    setup [:create_fee_arrear]

    test "displays fee_arrear", %{conn: conn, fee_arrear: fee_arrear} do
      {:ok, _show_live, html} = live(conn, ~p"/fee_arrears/#{fee_arrear}")

      assert html =~ "Show Fee arrear"
      assert html =~ fee_arrear.status
    end

    test "updates fee_arrear within modal", %{conn: conn, fee_arrear: fee_arrear} do
      {:ok, show_live, _html} = live(conn, ~p"/fee_arrears/#{fee_arrear}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fee arrear"

      assert_patch(show_live, ~p"/fee_arrears/#{fee_arrear}/show/edit")

      assert show_live
             |> form("#fee_arrear-form", fee_arrear: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#fee_arrear-form", fee_arrear: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fee_arrears/#{fee_arrear}")

      html = render(show_live)
      assert html =~ "Fee arrear updated successfully"
      assert html =~ "some updated status"
    end
  end
end
