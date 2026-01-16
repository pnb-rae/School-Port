defmodule Liveschool.BankTransactionsTest do
  use Liveschool.DataCase

  alias Liveschool.BankTransactions

  describe "bank_transactions" do
    alias Liveschool.BankTransactions.BankTransaction

    import Liveschool.BankTransactionsFixtures

    @invalid_attrs %{description: nil, transaction_type: nil, amount: nil, transaction_date: nil, reference_number: nil, related_record_id: nil, related_record_type: nil, balance_after: nil}

    test "list_bank_transactions/0 returns all bank_transactions" do
      bank_transaction = bank_transaction_fixture()
      assert BankTransactions.list_bank_transactions() == [bank_transaction]
    end

    test "get_bank_transaction!/1 returns the bank_transaction with given id" do
      bank_transaction = bank_transaction_fixture()
      assert BankTransactions.get_bank_transaction!(bank_transaction.id) == bank_transaction
    end

    test "create_bank_transaction/1 with valid data creates a bank_transaction" do
      valid_attrs = %{description: "some description", transaction_type: "some transaction_type", amount: "120.5", transaction_date: ~D[2025-12-10], reference_number: "some reference_number", related_record_id: 42, related_record_type: "some related_record_type", balance_after: "120.5"}

      assert {:ok, %BankTransaction{} = bank_transaction} = BankTransactions.create_bank_transaction(valid_attrs)
      assert bank_transaction.description == "some description"
      assert bank_transaction.transaction_type == "some transaction_type"
      assert bank_transaction.amount == Decimal.new("120.5")
      assert bank_transaction.transaction_date == ~D[2025-12-10]
      assert bank_transaction.reference_number == "some reference_number"
      assert bank_transaction.related_record_id == 42
      assert bank_transaction.related_record_type == "some related_record_type"
      assert bank_transaction.balance_after == Decimal.new("120.5")
    end

    test "create_bank_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BankTransactions.create_bank_transaction(@invalid_attrs)
    end

    test "update_bank_transaction/2 with valid data updates the bank_transaction" do
      bank_transaction = bank_transaction_fixture()
      update_attrs = %{description: "some updated description", transaction_type: "some updated transaction_type", amount: "456.7", transaction_date: ~D[2025-12-11], reference_number: "some updated reference_number", related_record_id: 43, related_record_type: "some updated related_record_type", balance_after: "456.7"}

      assert {:ok, %BankTransaction{} = bank_transaction} = BankTransactions.update_bank_transaction(bank_transaction, update_attrs)
      assert bank_transaction.description == "some updated description"
      assert bank_transaction.transaction_type == "some updated transaction_type"
      assert bank_transaction.amount == Decimal.new("456.7")
      assert bank_transaction.transaction_date == ~D[2025-12-11]
      assert bank_transaction.reference_number == "some updated reference_number"
      assert bank_transaction.related_record_id == 43
      assert bank_transaction.related_record_type == "some updated related_record_type"
      assert bank_transaction.balance_after == Decimal.new("456.7")
    end

    test "update_bank_transaction/2 with invalid data returns error changeset" do
      bank_transaction = bank_transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = BankTransactions.update_bank_transaction(bank_transaction, @invalid_attrs)
      assert bank_transaction == BankTransactions.get_bank_transaction!(bank_transaction.id)
    end

    test "delete_bank_transaction/1 deletes the bank_transaction" do
      bank_transaction = bank_transaction_fixture()
      assert {:ok, %BankTransaction{}} = BankTransactions.delete_bank_transaction(bank_transaction)
      assert_raise Ecto.NoResultsError, fn -> BankTransactions.get_bank_transaction!(bank_transaction.id) end
    end

    test "change_bank_transaction/1 returns a bank_transaction changeset" do
      bank_transaction = bank_transaction_fixture()
      assert %Ecto.Changeset{} = BankTransactions.change_bank_transaction(bank_transaction)
    end
  end
end
