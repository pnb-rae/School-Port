defmodule Liveschool.ImprestIssues do
  @moduledoc """
  The ImprestIssues context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.ImprestIssues.ImprestIssue

  @doc """
  Returns the list of imprest_issues.

  ## Examples

      iex> list_imprest_issues()
      [%ImprestIssue{}, ...]

  """
  def list_imprest_issues do
    Repo.all(ImprestIssue)
  end

  @doc """
  Gets a single imprest_issue.

  Raises `Ecto.NoResultsError` if the Imprest issue does not exist.

  ## Examples

      iex> get_imprest_issue!(123)
      %ImprestIssue{}

      iex> get_imprest_issue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_imprest_issue!(id), do: Repo.get!(ImprestIssue, id)

  @doc """
  Creates a imprest_issue.

  ## Examples

      iex> create_imprest_issue(%{field: value})
      {:ok, %ImprestIssue{}}

      iex> create_imprest_issue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_imprest_issue(attrs \\ %{}) do
    %ImprestIssue{}
    |> ImprestIssue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a imprest_issue.

  ## Examples

      iex> update_imprest_issue(imprest_issue, %{field: new_value})
      {:ok, %ImprestIssue{}}

      iex> update_imprest_issue(imprest_issue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_imprest_issue(%ImprestIssue{} = imprest_issue, attrs) do
    imprest_issue
    |> ImprestIssue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a imprest_issue.

  ## Examples

      iex> delete_imprest_issue(imprest_issue)
      {:ok, %ImprestIssue{}}

      iex> delete_imprest_issue(imprest_issue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_imprest_issue(%ImprestIssue{} = imprest_issue) do
    Repo.delete(imprest_issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking imprest_issue changes.

  ## Examples

      iex> change_imprest_issue(imprest_issue)
      %Ecto.Changeset{data: %ImprestIssue{}}

  """
  def change_imprest_issue(%ImprestIssue{} = imprest_issue, attrs \\ %{}) do
    ImprestIssue.changeset(imprest_issue, attrs)
  end
end
