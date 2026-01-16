defmodule LiveschoolWeb.FeeReceiptItemLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.FeeReceiptItemsFixtures

  @create_attrs %{amount: "120.5"}
  @update_attrs %{amount: "456.7"}
  @invalid_attrs %{amount: nil}

  defp create_fee_receipt_item(_) do
    fee_receipt_item = fee_receipt_item_fixture()
    %{fee_receipt_item: fee_receipt_item}
  end

  describe "Index" do
    setup [:create_fee_receipt_item]

    test "lists all fee_receipt_items", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/fee_receipt_items")

      assert html =~ "Listing Fee receipt items"
    end

    test "saves new fee_receipt_item", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipt_items")

      assert index_live |> element("a", "New Fee receipt item") |> render_click() =~
               "New Fee receipt item"

      assert_patch(index_live, ~p"/fee_receipt_items/new")

      assert index_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_receipt_items")

      html = render(index_live)
      assert html =~ "Fee receipt item created successfully"
    end

    test "updates fee_receipt_item in listing", %{conn: conn, fee_receipt_item: fee_receipt_item} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipt_items")

      assert index_live |> element("#fee_receipt_items-#{fee_receipt_item.id} a", "Edit") |> render_click() =~
               "Edit Fee receipt item"

      assert_patch(index_live, ~p"/fee_receipt_items/#{fee_receipt_item}/edit")

      assert index_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_receipt_items")

      html = render(index_live)
      assert html =~ "Fee receipt item updated successfully"
    end

    test "deletes fee_receipt_item in listing", %{conn: conn, fee_receipt_item: fee_receipt_item} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_receipt_items")

      assert index_live |> element("#fee_receipt_items-#{fee_receipt_item.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fee_receipt_items-#{fee_receipt_item.id}")
    end
  end

  describe "Show" do
    setup [:create_fee_receipt_item]

    test "displays fee_receipt_item", %{conn: conn, fee_receipt_item: fee_receipt_item} do
      {:ok, _show_live, html} = live(conn, ~p"/fee_receipt_items/#{fee_receipt_item}")

      assert html =~ "Show Fee receipt item"
    end

    test "updates fee_receipt_item within modal", %{conn: conn, fee_receipt_item: fee_receipt_item} do
      {:ok, show_live, _html} = live(conn, ~p"/fee_receipt_items/#{fee_receipt_item}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fee receipt item"

      assert_patch(show_live, ~p"/fee_receipt_items/#{fee_receipt_item}/show/edit")

      assert show_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#fee_receipt_item-form", fee_receipt_item: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fee_receipt_items/#{fee_receipt_item}")

      html = render(show_live)
      assert html =~ "Fee receipt item updated successfully"
    end
  end
end
