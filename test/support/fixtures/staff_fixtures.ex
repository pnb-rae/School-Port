defmodule Liveschool.StaffFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Staff` context.
  """

  @doc """
  Generate a unique staff_member staff_number.
  """
  def unique_staff_member_staff_number, do: "some staff_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a staff_member.
  """
  def staff_member_fixture(attrs \\ %{}) do
    {:ok, staff_member} =
      attrs
      |> Enum.into(%{
        account_number: "some account_number",
        date_of_birth: ~D[2025-12-10],
        email: "some email",
        first_name: "some first_name",
        hire_date: ~D[2025-12-10],
        last_name: "some last_name",
        phone: "some phone",
        position: "some position",
        salary: "120.5",
        staff_number: unique_staff_member_staff_number(),
        status: "some status"
      })
      |> Liveschool.Staff.create_staff_member()

    staff_member
  end
end
