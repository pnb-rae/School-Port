defmodule Liveschool.FeeStructures do
  @moduledoc """
  The FeeStructures context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.FeeStructures.FeeStructure

  @doc """
  Returns the list of fee_structures.

  ## Examples

      iex> list_fee_structures()
      [%FeeStructure{}, ...]

  """
  def list_fee_structures do
    Repo.all(FeeStructure)
  end

  @doc """
  Gets a single fee_structure.

  Raises `Ecto.NoResultsError` if the Fee structure does not exist.

  ## Examples

      iex> get_fee_structure!(123)
      %FeeStructure{}

      iex> get_fee_structure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_structure!(id), do: Repo.get!(FeeStructure, id)

  @doc """
  Creates a fee_structure.

  ## Examples

      iex> create_fee_structure(%{field: value})
      {:ok, %FeeStructure{}}

      iex> create_fee_structure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_structure(attrs \\ %{}) do
    %FeeStructure{}
    |> FeeStructure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_structure.

  ## Examples

      iex> update_fee_structure(fee_structure, %{field: new_value})
      {:ok, %FeeStructure{}}

      iex> update_fee_structure(fee_structure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_structure(%FeeStructure{} = fee_structure, attrs) do
    fee_structure
    |> FeeStructure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_structure.

  ## Examples

      iex> delete_fee_structure(fee_structure)
      {:ok, %FeeStructure{}}

      iex> delete_fee_structure(fee_structure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_structure(%FeeStructure{} = fee_structure) do
    Repo.delete(fee_structure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_structure changes.

  ## Examples

      iex> change_fee_structure(fee_structure)
      %Ecto.Changeset{data: %FeeStructure{}}

  """
  def change_fee_structure(%FeeStructure{} = fee_structure, attrs \\ %{}) do
    FeeStructure.changeset(fee_structure, attrs)
  end
end
