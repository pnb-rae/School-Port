defmodule Liveschool.PocketMoneyTransactionsTest do
  use Liveschool.DataCase

  alias Liveschool.PocketMoneyTransactions

  describe "pocket_money_transactions" do
    alias Liveschool.PocketMoneyTransactions.PocketMoneyTransaction

    import Liveschool.PocketMoneyTransactionsFixtures

    @invalid_attrs %{transaction_type: nil, amount: nil, balance_after: nil, transaction_date: nil, notes: nil}

    test "list_pocket_money_transactions/0 returns all pocket_money_transactions" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      assert PocketMoneyTransactions.list_pocket_money_transactions() == [pocket_money_transaction]
    end

    test "get_pocket_money_transaction!/1 returns the pocket_money_transaction with given id" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      assert PocketMoneyTransactions.get_pocket_money_transaction!(pocket_money_transaction.id) == pocket_money_transaction
    end

    test "create_pocket_money_transaction/1 with valid data creates a pocket_money_transaction" do
      valid_attrs = %{transaction_type: "some transaction_type", amount: "120.5", balance_after: "120.5", transaction_date: ~D[2025-12-10], notes: "some notes"}

      assert {:ok, %PocketMoneyTransaction{} = pocket_money_transaction} = PocketMoneyTransactions.create_pocket_money_transaction(valid_attrs)
      assert pocket_money_transaction.transaction_type == "some transaction_type"
      assert pocket_money_transaction.amount == Decimal.new("120.5")
      assert pocket_money_transaction.balance_after == Decimal.new("120.5")
      assert pocket_money_transaction.transaction_date == ~D[2025-12-10]
      assert pocket_money_transaction.notes == "some notes"
    end

    test "create_pocket_money_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PocketMoneyTransactions.create_pocket_money_transaction(@invalid_attrs)
    end

    test "update_pocket_money_transaction/2 with valid data updates the pocket_money_transaction" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      update_attrs = %{transaction_type: "some updated transaction_type", amount: "456.7", balance_after: "456.7", transaction_date: ~D[2025-12-11], notes: "some updated notes"}

      assert {:ok, %PocketMoneyTransaction{} = pocket_money_transaction} = PocketMoneyTransactions.update_pocket_money_transaction(pocket_money_transaction, update_attrs)
      assert pocket_money_transaction.transaction_type == "some updated transaction_type"
      assert pocket_money_transaction.amount == Decimal.new("456.7")
      assert pocket_money_transaction.balance_after == Decimal.new("456.7")
      assert pocket_money_transaction.transaction_date == ~D[2025-12-11]
      assert pocket_money_transaction.notes == "some updated notes"
    end

    test "update_pocket_money_transaction/2 with invalid data returns error changeset" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = PocketMoneyTransactions.update_pocket_money_transaction(pocket_money_transaction, @invalid_attrs)
      assert pocket_money_transaction == PocketMoneyTransactions.get_pocket_money_transaction!(pocket_money_transaction.id)
    end

    test "delete_pocket_money_transaction/1 deletes the pocket_money_transaction" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      assert {:ok, %PocketMoneyTransaction{}} = PocketMoneyTransactions.delete_pocket_money_transaction(pocket_money_transaction)
      assert_raise Ecto.NoResultsError, fn -> PocketMoneyTransactions.get_pocket_money_transaction!(pocket_money_transaction.id) end
    end

    test "change_pocket_money_transaction/1 returns a pocket_money_transaction changeset" do
      pocket_money_transaction = pocket_money_transaction_fixture()
      assert %Ecto.Changeset{} = PocketMoneyTransactions.change_pocket_money_transaction(pocket_money_transaction)
    end
  end
end
