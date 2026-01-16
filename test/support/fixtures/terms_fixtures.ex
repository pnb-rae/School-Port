defmodule Liveschool.TermsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Terms` context.
  """

  @doc """
  Generate a term.
  """
  def term_fixture(attrs \\ %{}) do
    {:ok, term} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        end_date: ~D[2025-12-10],
        is_current: true,
        name: "some name",
        start_date: ~D[2025-12-10]
      })
      |> Liveschool.Terms.create_term()

    term
  end
end
