defmodule Liveschool.FeeReceiptsTest do
  use Liveschool.DataCase

  alias Liveschool.FeeReceipts

  describe "fee_receipts" do
    alias Liveschool.FeeReceipts.FeeReceipt

    import Liveschool.FeeReceiptsFixtures

    @invalid_attrs %{term: nil, receipt_number: nil, amount: nil, payment_method: nil, transaction_reference: nil, payment_date: nil, academic_year: nil, notes: nil}

    test "list_fee_receipts/0 returns all fee_receipts" do
      fee_receipt = fee_receipt_fixture()
      assert FeeReceipts.list_fee_receipts() == [fee_receipt]
    end

    test "get_fee_receipt!/1 returns the fee_receipt with given id" do
      fee_receipt = fee_receipt_fixture()
      assert FeeReceipts.get_fee_receipt!(fee_receipt.id) == fee_receipt
    end

    test "create_fee_receipt/1 with valid data creates a fee_receipt" do
      valid_attrs = %{term: "some term", receipt_number: "some receipt_number", amount: "120.5", payment_method: "some payment_method", transaction_reference: "some transaction_reference", payment_date: ~D[2025-12-10], academic_year: "some academic_year", notes: "some notes"}

      assert {:ok, %FeeReceipt{} = fee_receipt} = FeeReceipts.create_fee_receipt(valid_attrs)
      assert fee_receipt.term == "some term"
      assert fee_receipt.receipt_number == "some receipt_number"
      assert fee_receipt.amount == Decimal.new("120.5")
      assert fee_receipt.payment_method == "some payment_method"
      assert fee_receipt.transaction_reference == "some transaction_reference"
      assert fee_receipt.payment_date == ~D[2025-12-10]
      assert fee_receipt.academic_year == "some academic_year"
      assert fee_receipt.notes == "some notes"
    end

    test "create_fee_receipt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeeReceipts.create_fee_receipt(@invalid_attrs)
    end

    test "update_fee_receipt/2 with valid data updates the fee_receipt" do
      fee_receipt = fee_receipt_fixture()
      update_attrs = %{term: "some updated term", receipt_number: "some updated receipt_number", amount: "456.7", payment_method: "some updated payment_method", transaction_reference: "some updated transaction_reference", payment_date: ~D[2025-12-11], academic_year: "some updated academic_year", notes: "some updated notes"}

      assert {:ok, %FeeReceipt{} = fee_receipt} = FeeReceipts.update_fee_receipt(fee_receipt, update_attrs)
      assert fee_receipt.term == "some updated term"
      assert fee_receipt.receipt_number == "some updated receipt_number"
      assert fee_receipt.amount == Decimal.new("456.7")
      assert fee_receipt.payment_method == "some updated payment_method"
      assert fee_receipt.transaction_reference == "some updated transaction_reference"
      assert fee_receipt.payment_date == ~D[2025-12-11]
      assert fee_receipt.academic_year == "some updated academic_year"
      assert fee_receipt.notes == "some updated notes"
    end

    test "update_fee_receipt/2 with invalid data returns error changeset" do
      fee_receipt = fee_receipt_fixture()
      assert {:error, %Ecto.Changeset{}} = FeeReceipts.update_fee_receipt(fee_receipt, @invalid_attrs)
      assert fee_receipt == FeeReceipts.get_fee_receipt!(fee_receipt.id)
    end

    test "delete_fee_receipt/1 deletes the fee_receipt" do
      fee_receipt = fee_receipt_fixture()
      assert {:ok, %FeeReceipt{}} = FeeReceipts.delete_fee_receipt(fee_receipt)
      assert_raise Ecto.NoResultsError, fn -> FeeReceipts.get_fee_receipt!(fee_receipt.id) end
    end

    test "change_fee_receipt/1 returns a fee_receipt changeset" do
      fee_receipt = fee_receipt_fixture()
      assert %Ecto.Changeset{} = FeeReceipts.change_fee_receipt(fee_receipt)
    end
  end
end
