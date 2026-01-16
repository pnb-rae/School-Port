defmodule Liveschool.PettyCashTransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.PettyCashTransactions` context.
  """

  @doc """
  Generate a petty_cash_transaction.
  """
  def petty_cash_transaction_fixture(attrs \\ %{}) do
    {:ok, petty_cash_transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        balance_after: "120.5",
        description: "some description",
        transaction_date: ~D[2025-12-10],
        transaction_type: "some transaction_type"
      })
      |> Liveschool.PettyCashTransactions.create_petty_cash_transaction()

    petty_cash_transaction
  end
end
