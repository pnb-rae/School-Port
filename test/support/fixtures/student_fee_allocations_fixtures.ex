defmodule Liveschool.StudentFeeAllocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.StudentFeeAllocations` context.
  """

  @doc """
  Generate a student_fee_allocation.
  """
  def student_fee_allocation_fixture(attrs \\ %{}) do
    {:ok, student_fee_allocation} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        amount_due: "120.5",
        amount_paid: "120.5",
        balance: "120.5",
        due_date: ~D[2025-12-10],
        status: "some status",
        term: "some term"
      })
      |> Liveschool.StudentFeeAllocations.create_student_fee_allocation()

    student_fee_allocation
  end
end
