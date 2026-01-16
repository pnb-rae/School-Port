defmodule LiveschoolWeb.BankTransactionLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.BankTransactionsFixtures

  @create_attrs %{description: "some description", transaction_type: "some transaction_type", amount: "120.5", transaction_date: "2025-12-10", reference_number: "some reference_number", related_record_id: 42, related_record_type: "some related_record_type", balance_after: "120.5"}
  @update_attrs %{description: "some updated description", transaction_type: "some updated transaction_type", amount: "456.7", transaction_date: "2025-12-11", reference_number: "some updated reference_number", related_record_id: 43, related_record_type: "some updated related_record_type", balance_after: "456.7"}
  @invalid_attrs %{description: nil, transaction_type: nil, amount: nil, transaction_date: nil, reference_number: nil, related_record_id: nil, related_record_type: nil, balance_after: nil}

  defp create_bank_transaction(_) do
    bank_transaction = bank_transaction_fixture()
    %{bank_transaction: bank_transaction}
  end

  describe "Index" do
    setup [:create_bank_transaction]

    test "lists all bank_transactions", %{conn: conn, bank_transaction: bank_transaction} do
      {:ok, _index_live, html} = live(conn, ~p"/bank_transactions")

      assert html =~ "Listing Bank transactions"
      assert html =~ bank_transaction.description
    end

    test "saves new bank_transaction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_transactions")

      assert index_live |> element("a", "New Bank transaction") |> render_click() =~
               "New Bank transaction"

      assert_patch(index_live, ~p"/bank_transactions/new")

      assert index_live
             |> form("#bank_transaction-form", bank_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank_transaction-form", bank_transaction: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bank_transactions")

      html = render(index_live)
      assert html =~ "Bank transaction created successfully"
      assert html =~ "some description"
    end

    test "updates bank_transaction in listing", %{conn: conn, bank_transaction: bank_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_transactions")

      assert index_live |> element("#bank_transactions-#{bank_transaction.id} a", "Edit") |> render_click() =~
               "Edit Bank transaction"

      assert_patch(index_live, ~p"/bank_transactions/#{bank_transaction}/edit")

      assert index_live
             |> form("#bank_transaction-form", bank_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank_transaction-form", bank_transaction: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bank_transactions")

      html = render(index_live)
      assert html =~ "Bank transaction updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes bank_transaction in listing", %{conn: conn, bank_transaction: bank_transaction} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_transactions")

      assert index_live |> element("#bank_transactions-#{bank_transaction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bank_transactions-#{bank_transaction.id}")
    end
  end

  describe "Show" do
    setup [:create_bank_transaction]

    test "displays bank_transaction", %{conn: conn, bank_transaction: bank_transaction} do
      {:ok, _show_live, html} = live(conn, ~p"/bank_transactions/#{bank_transaction}")

      assert html =~ "Show Bank transaction"
      assert html =~ bank_transaction.description
    end

    test "updates bank_transaction within modal", %{conn: conn, bank_transaction: bank_transaction} do
      {:ok, show_live, _html} = live(conn, ~p"/bank_transactions/#{bank_transaction}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bank transaction"

      assert_patch(show_live, ~p"/bank_transactions/#{bank_transaction}/show/edit")

      assert show_live
             |> form("#bank_transaction-form", bank_transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bank_transaction-form", bank_transaction: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bank_transactions/#{bank_transaction}")

      html = render(show_live)
      assert html =~ "Bank transaction updated successfully"
      assert html =~ "some updated description"
    end
  end
end
