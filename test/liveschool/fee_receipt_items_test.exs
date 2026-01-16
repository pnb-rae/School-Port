defmodule Liveschool.FeeReceiptItemsTest do
  use Liveschool.DataCase

  alias Liveschool.FeeReceiptItems

  describe "fee_receipt_items" do
    alias Liveschool.FeeReceiptItems.FeeReceiptItem

    import Liveschool.FeeReceiptItemsFixtures

    @invalid_attrs %{amount: nil}

    test "list_fee_receipt_items/0 returns all fee_receipt_items" do
      fee_receipt_item = fee_receipt_item_fixture()
      assert FeeReceiptItems.list_fee_receipt_items() == [fee_receipt_item]
    end

    test "get_fee_receipt_item!/1 returns the fee_receipt_item with given id" do
      fee_receipt_item = fee_receipt_item_fixture()
      assert FeeReceiptItems.get_fee_receipt_item!(fee_receipt_item.id) == fee_receipt_item
    end

    test "create_fee_receipt_item/1 with valid data creates a fee_receipt_item" do
      valid_attrs = %{amount: "120.5"}

      assert {:ok, %FeeReceiptItem{} = fee_receipt_item} = FeeReceiptItems.create_fee_receipt_item(valid_attrs)
      assert fee_receipt_item.amount == Decimal.new("120.5")
    end

    test "create_fee_receipt_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeeReceiptItems.create_fee_receipt_item(@invalid_attrs)
    end

    test "update_fee_receipt_item/2 with valid data updates the fee_receipt_item" do
      fee_receipt_item = fee_receipt_item_fixture()
      update_attrs = %{amount: "456.7"}

      assert {:ok, %FeeReceiptItem{} = fee_receipt_item} = FeeReceiptItems.update_fee_receipt_item(fee_receipt_item, update_attrs)
      assert fee_receipt_item.amount == Decimal.new("456.7")
    end

    test "update_fee_receipt_item/2 with invalid data returns error changeset" do
      fee_receipt_item = fee_receipt_item_fixture()
      assert {:error, %Ecto.Changeset{}} = FeeReceiptItems.update_fee_receipt_item(fee_receipt_item, @invalid_attrs)
      assert fee_receipt_item == FeeReceiptItems.get_fee_receipt_item!(fee_receipt_item.id)
    end

    test "delete_fee_receipt_item/1 deletes the fee_receipt_item" do
      fee_receipt_item = fee_receipt_item_fixture()
      assert {:ok, %FeeReceiptItem{}} = FeeReceiptItems.delete_fee_receipt_item(fee_receipt_item)
      assert_raise Ecto.NoResultsError, fn -> FeeReceiptItems.get_fee_receipt_item!(fee_receipt_item.id) end
    end

    test "change_fee_receipt_item/1 returns a fee_receipt_item changeset" do
      fee_receipt_item = fee_receipt_item_fixture()
      assert %Ecto.Changeset{} = FeeReceiptItems.change_fee_receipt_item(fee_receipt_item)
    end
  end
end
