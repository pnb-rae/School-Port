defmodule Liveschool.VoteHeads do
  @moduledoc """
  The VoteHeads context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.VoteHeads.VoteHead

  @doc """
  Returns the list of vote_heads.

  ## Examples

      iex> list_vote_heads()
      [%VoteHead{}, ...]

  """
  def list_vote_heads do
    Repo.all(VoteHead)
  end

  @doc """
  Gets a single vote_head.

  Raises `Ecto.NoResultsError` if the Vote head does not exist.

  ## Examples

      iex> get_vote_head!(123)
      %VoteHead{}

      iex> get_vote_head!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vote_head!(id), do: Repo.get!(VoteHead, id)

  @doc """
  Creates a vote_head.

  ## Examples

      iex> create_vote_head(%{field: value})
      {:ok, %VoteHead{}}

      iex> create_vote_head(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vote_head(attrs \\ %{}) do
    %VoteHead{}
    |> VoteHead.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vote_head.

  ## Examples

      iex> update_vote_head(vote_head, %{field: new_value})
      {:ok, %VoteHead{}}

      iex> update_vote_head(vote_head, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vote_head(%VoteHead{} = vote_head, attrs) do
    vote_head
    |> VoteHead.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vote_head.

  ## Examples

      iex> delete_vote_head(vote_head)
      {:ok, %VoteHead{}}

      iex> delete_vote_head(vote_head)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vote_head(%VoteHead{} = vote_head) do
    Repo.delete(vote_head)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vote_head changes.

  ## Examples

      iex> change_vote_head(vote_head)
      %Ecto.Changeset{data: %VoteHead{}}

  """
  def change_vote_head(%VoteHead{} = vote_head, attrs \\ %{}) do
    VoteHead.changeset(vote_head, attrs)
  end
end
