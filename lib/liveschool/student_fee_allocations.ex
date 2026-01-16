defmodule Liveschool.StudentFeeAllocations do
  @moduledoc """
  The StudentFeeAllocations context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.StudentFeeAllocations.StudentFeeAllocation

  @doc """
  Returns the list of student_fee_allocations.

  ## Examples

      iex> list_student_fee_allocations()
      [%StudentFeeAllocation{}, ...]

  """
  def list_student_fee_allocations do
    Repo.all(StudentFeeAllocation)
  end

  @doc """
  Gets a single student_fee_allocation.

  Raises `Ecto.NoResultsError` if the Student fee allocation does not exist.

  ## Examples

      iex> get_student_fee_allocation!(123)
      %StudentFeeAllocation{}

      iex> get_student_fee_allocation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student_fee_allocation!(id), do: Repo.get!(StudentFeeAllocation, id)

  @doc """
  Creates a student_fee_allocation.

  ## Examples

      iex> create_student_fee_allocation(%{field: value})
      {:ok, %StudentFeeAllocation{}}

      iex> create_student_fee_allocation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student_fee_allocation(attrs \\ %{}) do
    %StudentFeeAllocation{}
    |> StudentFeeAllocation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student_fee_allocation.

  ## Examples

      iex> update_student_fee_allocation(student_fee_allocation, %{field: new_value})
      {:ok, %StudentFeeAllocation{}}

      iex> update_student_fee_allocation(student_fee_allocation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student_fee_allocation(%StudentFeeAllocation{} = student_fee_allocation, attrs) do
    student_fee_allocation
    |> StudentFeeAllocation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student_fee_allocation.

  ## Examples

      iex> delete_student_fee_allocation(student_fee_allocation)
      {:ok, %StudentFeeAllocation{}}

      iex> delete_student_fee_allocation(student_fee_allocation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student_fee_allocation(%StudentFeeAllocation{} = student_fee_allocation) do
    Repo.delete(student_fee_allocation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student_fee_allocation changes.

  ## Examples

      iex> change_student_fee_allocation(student_fee_allocation)
      %Ecto.Changeset{data: %StudentFeeAllocation{}}

  """
  def change_student_fee_allocation(%StudentFeeAllocation{} = student_fee_allocation, attrs \\ %{}) do
    StudentFeeAllocation.changeset(student_fee_allocation, attrs)
  end
end
