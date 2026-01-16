defmodule Liveschool.SchoolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Schools` context.
  """

  @doc """
  Generate a unique school code.
  """
  def unique_school_code, do: "some code#{System.unique_integer([:positive])}"

  @doc """
  Generate a school.
  """
  def school_fixture(attrs \\ %{}) do
    {:ok, school} =
      attrs
      |> Enum.into(%{
        address: "some address",
        code: unique_school_code(),
        current_academic_year: "some current_academic_year",
        email: "some email",
        established_date: ~D[2025-12-10],
        logo_url: "some logo_url",
        name: "some name",
        phone: "some phone",
        settings: %{}
      })
      |> Liveschool.Schools.create_school()

    school
  end
end
