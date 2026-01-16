defmodule LiveschoolWeb.PettyCashTransactionLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.PettyCashTransactionsFixtures

  @create_attrs %{description: "some description", transaction_type: "some transaction_type", amount: "120.5", transaction_date: "2025-12-10", balance_after: "120.5"}
  @update_attrs %{description: "some updated description", transaction_type: "some updated transaction_type", amount: "456.7", transaction_date: "2025-12-11", balance_after: "456.7"}
  @invalid_attrs %{description: nil, transaction_type: nil, amount: nil, transaction_date: nil, balance_after: nil}

  defp create_petty_cash_transaction(_) do
    petty_cash_transaction = petty_cash_transaction_fixture()
    %{petty_cash_transaction: petty_cash_transaction}
  end

  describe "Index" do
    setup [:create_petty_cash_transaction]

    test "lists all petty_cash_transactions", %{conn: conn, petty_cash_transaction: petty_cash_transaction} do
      {:ok, _index_live, html} = live(conn, ~p"/petty_cash_transactions")

      assert html =~ "Listing Petty cash transactions"
      assert html =~ petty_cash_transaction.description
    end

    test "saves new petty_cash_transaction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/petty_cash_transactions")

      assert index_live |> element("a", "New Petty cash transaction") |> render_click() =~
               "New Petty cash transaction"

      assert_patch(index_live, ~p"/petty_cash_transactions/new")

      assert index_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/petty_cash_transactions")

      html = render(index_live)
      assert html =~ "Petty cash transaction created successfully"
      assert html =~ "some description"
    end

    test "updates petty_cash_transaction in listing", %{conn: conn, petty_cash_transaction: petty_cash_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/petty_cash_transactions")

      assert index_live |> element("#petty_cash_transactions-#{petty_cash_transaction.id} a", "Edit") |> render_click() =~
               "Edit Petty cash transaction"

      assert_patch(index_live, ~p"/petty_cash_transactions/#{petty_cash_transaction}/edit")

      assert index_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/petty_cash_transactions")

      html = render(index_live)
      assert html =~ "Petty cash transaction updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes petty_cash_transaction in listing", %{conn: conn, petty_cash_transaction: petty_cash_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/petty_cash_transactions")

      assert index_live |> element("#petty_cash_transactions-#{petty_cash_transaction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#petty_cash_transactions-#{petty_cash_transaction.id}")
    end
  end

  describe "Show" do
    setup [:create_petty_cash_transaction]

    test "displays petty_cash_transaction", %{conn: conn, petty_cash_transaction: petty_cash_transaction} do
      {:ok, _show_live, html} = live(conn, ~p"/petty_cash_transactions/#{petty_cash_transaction}")

      assert html =~ "Show Petty cash transaction"
      assert html =~ petty_cash_transaction.description
    end

    test "updates petty_cash_transaction within modal", %{conn: conn, petty_cash_transaction: petty_cash_transaction} do
      {:ok, show_live, _html} = live(conn, ~p"/petty_cash_transactions/#{petty_cash_transaction}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Petty cash transaction"

      assert_patch(show_live, ~p"/petty_cash_transactions/#{petty_cash_transaction}/show/edit")

      assert show_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#petty_cash_transaction-form", petty_cash_transaction: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/petty_cash_transactions/#{petty_cash_transaction}")

      html = render(show_live)
      assert html =~ "Petty cash transaction updated successfully"
      assert html =~ "some updated description"
    end
  end
end
