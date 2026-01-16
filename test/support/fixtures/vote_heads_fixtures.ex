defmodule Liveschool.VoteHeadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.VoteHeads` context.
  """

  @doc """
  Generate a vote_head.
  """
  def vote_head_fixture(attrs \\ %{}) do
    {:ok, vote_head} =
      attrs
      |> Enum.into(%{
        academic_year: "some academic_year",
        budget_amount: "120.5",
        code: "some code",
        description: "some description",
        is_active: true,
        name: "some name",
        spent_amount: "120.5"
      })
      |> Liveschool.VoteHeads.create_vote_head()

    vote_head
  end
end
