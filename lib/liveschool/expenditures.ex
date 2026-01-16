defmodule Liveschool.Expenditures do
  @moduledoc """
  The Expenditures context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.Expenditures.Expenditure

  @doc """
  Returns the list of expenditures.

  ## Examples

      iex> list_expenditures()
      [%Expenditure{}, ...]

  """
  def list_expenditures do
    Repo.all(Expenditure)
  end

  @doc """
  Gets a single expenditure.

  Raises `Ecto.NoResultsError` if the Expenditure does not exist.

  ## Examples

      iex> get_expenditure!(123)
      %Expenditure{}

      iex> get_expenditure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expenditure!(id), do: Repo.get!(Expenditure, id)

  @doc """
  Creates a expenditure.

  ## Examples

      iex> create_expenditure(%{field: value})
      {:ok, %Expenditure{}}

      iex> create_expenditure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expenditure(attrs \\ %{}) do
    %Expenditure{}
    |> Expenditure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expenditure.

  ## Examples

      iex> update_expenditure(expenditure, %{field: new_value})
      {:ok, %Expenditure{}}

      iex> update_expenditure(expenditure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expenditure(%Expenditure{} = expenditure, attrs) do
    expenditure
    |> Expenditure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expenditure.

  ## Examples

      iex> delete_expenditure(expenditure)
      {:ok, %Expenditure{}}

      iex> delete_expenditure(expenditure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expenditure(%Expenditure{} = expenditure) do
    Repo.delete(expenditure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expenditure changes.

  ## Examples

      iex> change_expenditure(expenditure)
      %Ecto.Changeset{data: %Expenditure{}}

  """
  def change_expenditure(%Expenditure{} = expenditure, attrs \\ %{}) do
    Expenditure.changeset(expenditure, attrs)
  end
end
