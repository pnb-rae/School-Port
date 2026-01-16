defmodule Liveschool.PocketMoneyTransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.PocketMoneyTransactions` context.
  """

  @doc """
  Generate a pocket_money_transaction.
  """
  def pocket_money_transaction_fixture(attrs \\ %{}) do
    {:ok, pocket_money_transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        balance_after: "120.5",
        notes: "some notes",
        transaction_date: ~D[2025-12-10],
        transaction_type: "some transaction_type"
      })
      |> Liveschool.PocketMoneyTransactions.create_pocket_money_transaction()

    pocket_money_transaction
  end
end
