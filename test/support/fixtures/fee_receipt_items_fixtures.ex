defmodule Liveschool.FeeReceiptItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.FeeReceiptItems` context.
  """

  @doc """
  Generate a fee_receipt_item.
  """
  def fee_receipt_item_fixture(attrs \\ %{}) do
    {:ok, fee_receipt_item} =
      attrs
      |> Enum.into(%{
        amount: "120.5"
      })
      |> Liveschool.FeeReceiptItems.create_fee_receipt_item()

    fee_receipt_item
  end
end
