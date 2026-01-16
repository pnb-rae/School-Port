defmodule LiveschoolWeb.PocketMoneyTransactionLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.PocketMoneyTransactionsFixtures

  @create_attrs %{transaction_type: "some transaction_type", amount: "120.5", balance_after: "120.5", transaction_date: "2025-12-10", notes: "some notes"}
  @update_attrs %{transaction_type: "some updated transaction_type", amount: "456.7", balance_after: "456.7", transaction_date: "2025-12-11", notes: "some updated notes"}
  @invalid_attrs %{transaction_type: nil, amount: nil, balance_after: nil, transaction_date: nil, notes: nil}

  defp create_pocket_money_transaction(_) do
    pocket_money_transaction = pocket_money_transaction_fixture()
    %{pocket_money_transaction: pocket_money_transaction}
  end

  describe "Index" do
    setup [:create_pocket_money_transaction]

    test "lists all pocket_money_transactions", %{conn: conn, pocket_money_transaction: pocket_money_transaction} do
      {:ok, _index_live, html} = live(conn, ~p"/pocket_money_transactions")

      assert html =~ "Listing Pocket money transactions"
      assert html =~ pocket_money_transaction.transaction_type
    end

    test "saves new pocket_money_transaction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pocket_money_transactions")

      assert index_live |> element("a", "New Pocket money transaction") |> render_click() =~
               "New Pocket money transaction"

      assert_patch(index_live, ~p"/pocket_money_transactions/new")

      assert index_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pocket_money_transactions")

      html = render(index_live)
      assert html =~ "Pocket money transaction created successfully"
      assert html =~ "some transaction_type"
    end

    test "updates pocket_money_transaction in listing", %{conn: conn, pocket_money_transaction: pocket_money_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/pocket_money_transactions")

      assert index_live |> element("#pocket_money_transactions-#{pocket_money_transaction.id} a", "Edit") |> render_click() =~
               "Edit Pocket money transaction"

      assert_patch(index_live, ~p"/pocket_money_transactions/#{pocket_money_transaction}/edit")

      assert index_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pocket_money_transactions")

      html = render(index_live)
      assert html =~ "Pocket money transaction updated successfully"
      assert html =~ "some updated transaction_type"
    end

    test "deletes pocket_money_transaction in listing", %{conn: conn, pocket_money_transaction: pocket_money_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/pocket_money_transactions")

      assert index_live |> element("#pocket_money_transactions-#{pocket_money_transaction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pocket_money_transactions-#{pocket_money_transaction.id}")
    end
  end

  describe "Show" do
    setup [:create_pocket_money_transaction]

    test "displays pocket_money_transaction", %{conn: conn, pocket_money_transaction: pocket_money_transaction} do
      {:ok, _show_live, html} = live(conn, ~p"/pocket_money_transactions/#{pocket_money_transaction}")

      assert html =~ "Show Pocket money transaction"
      assert html =~ pocket_money_transaction.transaction_type
    end

    test "updates pocket_money_transaction within modal", %{conn: conn, pocket_money_transaction: pocket_money_transaction} do
      {:ok, show_live, _html} = live(conn, ~p"/pocket_money_transactions/#{pocket_money_transaction}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pocket money transaction"

      assert_patch(show_live, ~p"/pocket_money_transactions/#{pocket_money_transaction}/show/edit")

      assert show_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pocket_money_transaction-form", pocket_money_transaction: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/pocket_money_transactions/#{pocket_money_transaction}")

      html = render(show_live)
      assert html =~ "Pocket money transaction updated successfully"
      assert html =~ "some updated transaction_type"
    end
  end
end
