defmodule Liveschool.FeeReceiptsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.FeeReceipts` context.
  """

  @doc """
  Generate a unique fee_receipt receipt_number.
  """
  def unique_fee_receipt_receipt_number, do: "some receipt_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a fee_receipt.
  """
  def fee_receipt_fixture(attrs \\ %{}) do
    {:ok, fee_receipt} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        amount: "120.5",
        notes: "some notes",
        payment_date: ~D[2025-12-10],
        payment_method: "some payment_method",
        receipt_number: unique_fee_receipt_receipt_number(),
        term: "some term",
        transaction_reference: "some transaction_reference"
      })
      |> Liveschool.FeeReceipts.create_fee_receipt()

    fee_receipt
  end
end
