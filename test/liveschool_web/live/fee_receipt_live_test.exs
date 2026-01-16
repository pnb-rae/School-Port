defmodule LiveschoolWeb.FeeReceiptLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.FeeReceiptsFixtures

  @create_attrs %{term: "some term", receipt_number: "some receipt_number", amount: "120.5", payment_method: "some payment_method", transaction_reference: "some transaction_reference", payment_date: "2025-12-10", academic_year: "some academic_year", notes: "some notes"}
  @update_attrs %{term: "some updated term", receipt_number: "some updated receipt_number", amount: "456.7", payment_method: "some updated payment_method", transaction_reference: "some updated transaction_reference", payment_date: "2025-12-11", academic_year: "some updated academic_year", notes: "some updated notes"}
  @invalid_attrs %{term: nil, receipt_number: nil, amount: nil, payment_method: nil, transaction_reference: nil, payment_date: nil, academic_year: nil, notes: nil}

  defp create_fee_receipt(_) do
    fee_receipt = fee_receipt_fixture()
    %{fee_receipt: fee_receipt}
  end

  describe "Index" do
    setup [:create_fee_receipt]

    test "lists all fee_receipts", %{conn: conn, fee_receipt: fee_receipt} do
      {:ok, _index_live, html} = live(conn, ~p"/fee_receipts")

      assert html =~ "Listing Fee receipts"
      assert html =~ fee_receipt.term
    end

    test "saves new fee_receipt", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipts")

      assert index_live |> element("a", "New Fee receipt") |> render_click() =~
               "New Fee receipt"

      assert_patch(index_live, ~p"/fee_receipts/new")

      assert index_live
             |> form("#fee_receipt-form", fee_receipt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_receipt-form", fee_receipt: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_receipts")

      html = render(index_live)
      assert html =~ "Fee receipt created successfully"
      assert html =~ "some term"
    end

    test "updates fee_receipt in listing", %{conn: conn, fee_receipt: fee_receipt} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipts")

      assert index_live |> element("#fee_receipts-#{fee_receipt.id} a", "Edit") |> render_click() =~
               "Edit Fee receipt"

      assert_patch(index_live, ~p"/fee_receipts/#{fee_receipt}/edit")

      assert index_live
             |> form("#fee_receipt-form", fee_receipt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_receipt-form", fee_receipt: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_receipts")

      html = render(index_live)
      assert html =~ "Fee receipt updated successfully"
      assert html =~ "some updated term"
    end

    test "deletes fee_receipt in listing", %{conn: conn, fee_receipt: fee_receipt} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipts")

      assert index_live |> element("#fee_receipts-#{fee_receipt.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fee_receipts-#{fee_receipt.id}")
    end
  end

  describe "Show" do
    setup [:create_fee_receipt]

    test "displays fee_receipt", %{conn: conn, fee_receipt: fee_receipt} do
      {:ok, _show_live, html} = live(conn, ~p"/fee_receipts/#{fee_receipt}")

      assert html =~ "Show Fee receipt"
      assert html =~ fee_receipt.term
    end

    test "updates fee_receipt within modal", %{conn: conn, fee_receipt: fee_receipt} do
      {:ok, show_live, _html} = live(conn, ~p"/fee_receipts/#{fee_receipt}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fee receipt"

      assert_patch(show_live, ~p"/fee_receipts/#{fee_receipt}/show/edit")

      assert show_live
             |> form("#fee_receipt-form", fee_receipt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#fee_receipt-form", fee_receipt: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fee_receipts/#{fee_receipt}")

      html = render(show_live)
      assert html =~ "Fee receipt updated successfully"
      assert html =~ "some updated term"
    end
  end
end
