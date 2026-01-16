defmodule Liveschool.PettyCashTransactionsTest do
  use Liveschool.DataCase

  alias Liveschool.PettyCashTransactions

  describe "petty_cash_transactions" do
    alias Liveschool.PettyCashTransactions.PettyCashTransaction

    import Liveschool.PettyCashTransactionsFixtures

    @invalid_attrs %{description: nil, transaction_type: nil, amount: nil, transaction_date: nil, balance_after: nil}

    test "list_petty_cash_transactions/0 returns all petty_cash_transactions" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      assert PettyCashTransactions.list_petty_cash_transactions() == [petty_cash_transaction]
    end

    test "get_petty_cash_transaction!/1 returns the petty_cash_transaction with given id" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      assert PettyCashTransactions.get_petty_cash_transaction!(petty_cash_transaction.id) == petty_cash_transaction
    end

    test "create_petty_cash_transaction/1 with valid data creates a petty_cash_transaction" do
      valid_attrs = %{description: "some description", transaction_type: "some transaction_type", amount: "120.5", transaction_date: ~D[2025-12-10], balance_after: "120.5"}

      assert {:ok, %PettyCashTransaction{} = petty_cash_transaction} = PettyCashTransactions.create_petty_cash_transaction(valid_attrs)
      assert petty_cash_transaction.description == "some description"
      assert petty_cash_transaction.transaction_type == "some transaction_type"
      assert petty_cash_transaction.amount == Decimal.new("120.5")
      assert petty_cash_transaction.transaction_date == ~D[2025-12-10]
      assert petty_cash_transaction.balance_after == Decimal.new("120.5")
    end

    test "create_petty_cash_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PettyCashTransactions.create_petty_cash_transaction(@invalid_attrs)
    end

    test "update_petty_cash_transaction/2 with valid data updates the petty_cash_transaction" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      update_attrs = %{description: "some updated description", transaction_type: "some updated transaction_type", amount: "456.7", transaction_date: ~D[2025-12-11], balance_after: "456.7"}

      assert {:ok, %PettyCashTransaction{} = petty_cash_transaction} = PettyCashTransactions.update_petty_cash_transaction(petty_cash_transaction, update_attrs)
      assert petty_cash_transaction.description == "some updated description"
      assert petty_cash_transaction.transaction_type == "some updated transaction_type"
      assert petty_cash_transaction.amount == Decimal.new("456.7")
      assert petty_cash_transaction.transaction_date == ~D[2025-12-11]
      assert petty_cash_transaction.balance_after == Decimal.new("456.7")
    end

    test "update_petty_cash_transaction/2 with invalid data returns error changeset" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = PettyCashTransactions.update_petty_cash_transaction(petty_cash_transaction, @invalid_attrs)
      assert petty_cash_transaction == PettyCashTransactions.get_petty_cash_transaction!(petty_cash_transaction.id)
    end

    test "delete_petty_cash_transaction/1 deletes the petty_cash_transaction" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      assert {:ok, %PettyCashTransaction{}} = PettyCashTransactions.delete_petty_cash_transaction(petty_cash_transaction)
      assert_raise Ecto.NoResultsError, fn -> PettyCashTransactions.get_petty_cash_transaction!(petty_cash_transaction.id) end
    end

    test "change_petty_cash_transaction/1 returns a petty_cash_transaction changeset" do
      petty_cash_transaction = petty_cash_transaction_fixture()
      assert %Ecto.Changeset{} = PettyCashTransactions.change_petty_cash_transaction(petty_cash_transaction)
    end
  end
end
