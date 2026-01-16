defmodule Liveschool.ImprestIssuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.ImprestIssues` context.
  """

  @doc """
  Generate a imprest_issue.
  """
  def imprest_issue_fixture(attrs \\ %{}) do
    {:ok, imprest_issue} =
      attrs
      |> Enum.into(%{
        amount_issued: "120.5",
        amount_returned: "120.5",
        balance: "120.5",
        issue_date: ~D[2025-12-10],
        purpose: "some purpose",
        return_date: ~D[2025-12-10],
        status: "some status"
      })
      |> Liveschool.ImprestIssues.create_imprest_issue()

    imprest_issue
  end
end
