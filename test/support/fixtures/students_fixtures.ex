defmodule Liveschool.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Students` context.
  """

  @doc """
  Generate a unique student admission_number.
  """
  def unique_student_admission_number, do: "some admission_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        address: "some address",
        admission_date: ~D[2025-12-10],
        admission_number: unique_student_admission_number(),
        date_of_birth: ~D[2025-12-10],
        first_name: "some first_name",
        gender: "some gender",
        last_name: "some last_name",
        middle_name: "some middle_name",
        parent_guardian_email: "some parent_guardian_email",
        parent_guardian_name: "some parent_guardian_name",
        parent_guardian_phone: "some parent_guardian_phone",
        photo_url: "some photo_url",
        status: "some status"
      })
      |> Liveschool.Students.create_student()

    student
  end
end
