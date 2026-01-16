defmodule Liveschool.FeeArrearsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.FeeArrears` context.
  """

  @doc """
  Generate a fee_arrear.
  """
  def fee_arrear_fixture(attrs \\ %{}) do
    {:ok, fee_arrear} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        amount: "120.5",
        notes: "some notes",
        status: "some status",
        term: "some term"
      })
      |> Liveschool.FeeArrears.create_fee_arrear()

    fee_arrear
  end
end
