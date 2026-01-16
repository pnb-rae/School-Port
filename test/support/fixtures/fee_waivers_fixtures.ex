defmodule Liveschool.FeeWaiversFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.FeeWaivers` context.
  """

  @doc """
  Generate a fee_waiver.
  """
  def fee_waiver_fixture(attrs \\ %{}) do
    {:ok, fee_waiver} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        amount_or_percentage: "120.5",
        reason: "some reason",
        term: "some term",
        waiver_type: "some waiver_type"
      })
      |> Liveschool.FeeWaivers.create_fee_waiver()

    fee_waiver
  end
end
