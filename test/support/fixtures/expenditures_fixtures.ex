defmodule Liveschool.ExpendituresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Expenditures` context.
  """

  @doc """
  Generate a unique expenditure payment_number.
  """
  def unique_expenditure_payment_number, do: "some payment_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a expenditure.
  """
  def expenditure_fixture(attrs \\ %{}) do
    {:ok, expenditure} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        description: "some description",
        payee_id: 42,
        payee_type: "some payee_type",
        payment_date: ~D[2025-12-10],
        payment_method: "some payment_method",
        payment_number: unique_expenditure_payment_number(),
        status: "some status"
      })
      |> Liveschool.Expenditures.create_expenditure()

    expenditure
  end
end
