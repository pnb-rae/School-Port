defmodule Liveschool.FeeStructuresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.FeeStructures` context.
  """

  @doc """
  Generate a fee_structure.
  """
  def fee_structure_fixture(attrs \\ %{}) do
    {:ok, fee_structure} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        amount: "120.5",
        fee_type: "some fee_type",
        is_mandatory: true,
        name: "some name",
        payment_frequency: "some payment_frequency",
        term: "some term"
      })
      |> Liveschool.FeeStructures.create_fee_structure()

    fee_structure
  end
end
