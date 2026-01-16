defmodule Liveschool.DepartmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Departments` context.
  """

  @doc """
  Generate a department.
  """
  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(%{
        budget_allocation: "120.5",
        code: "some code",
        name: "some name"
      })
      |> Liveschool.Departments.create_department()

    department
  end
end
