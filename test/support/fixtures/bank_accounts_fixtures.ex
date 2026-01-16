defmodule Liveschool.BankAccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.BankAccounts` context.
  """

  @doc """
  Generate a bank_account.
  """
  def bank_account_fixture(attrs \\ %{}) do
    {:ok, bank_account} =
      attrs
      |> Enum.into(%{
        account_name: "some account_name",
        account_number: "some account_number",
        branch: "some branch",
        current_balance: "120.5",
        is_active: true,
        name: "some name",
        opening_balance: "120.5"
      })
      |> Liveschool.BankAccounts.create_bank_account()

    bank_account
  end
end
