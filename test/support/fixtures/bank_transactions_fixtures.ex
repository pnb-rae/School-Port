defmodule Liveschool.BankTransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.BankTransactions` context.
  """

  @doc """
  Generate a bank_transaction.
  """
  def bank_transaction_fixture(attrs \\ %{}) do
    {:ok, bank_transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        balance_after: "120.5",
        description: "some description",
        reference_number: "some reference_number",
        related_record_id: 42,
        related_record_type: "some related_record_type",
        transaction_date: ~D[2025-12-10],
        transaction_type: "some transaction_type"
      })
      |> Liveschool.BankTransactions.create_bank_transaction()

    bank_transaction
  end
end
