defmodule Liveschool.ClassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Classes` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        capacity: 42,
        level: 42,
        name: "some name"
      })
      |> Liveschool.Classes.create_class()

    class
  end
end
