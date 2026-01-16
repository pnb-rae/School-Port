defmodule Liveschool.FeeArrears do
  @moduledoc """
  The FeeArrears context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.FeeArrears.FeeArrear

  @doc """
  Returns the list of fee_arrears.

  ## Examples

      iex> list_fee_arrears()
      [%FeeArrear{}, ...]

  """
  def list_fee_arrears do
    Repo.all(FeeArrear)
  end

  @doc """
  Gets a single fee_arrear.

  Raises `Ecto.NoResultsError` if the Fee arrear does not exist.

  ## Examples

      iex> get_fee_arrear!(123)
      %FeeArrear{}

      iex> get_fee_arrear!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_arrear!(id), do: Repo.get!(FeeArrear, id)

  @doc """
  Creates a fee_arrear.

  ## Examples

      iex> create_fee_arrear(%{field: value})
      {:ok, %FeeArrear{}}

      iex> create_fee_arrear(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_arrear(attrs \\ %{}) do
    %FeeArrear{}
    |> FeeArrear.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_arrear.

  ## Examples

      iex> update_fee_arrear(fee_arrear, %{field: new_value})
      {:ok, %FeeArrear{}}

      iex> update_fee_arrear(fee_arrear, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_arrear(%FeeArrear{} = fee_arrear, attrs) do
    fee_arrear
    |> FeeArrear.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_arrear.

  ## Examples

      iex> delete_fee_arrear(fee_arrear)
      {:ok, %FeeArrear{}}

      iex> delete_fee_arrear(fee_arrear)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_arrear(%FeeArrear{} = fee_arrear) do
    Repo.delete(fee_arrear)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_arrear changes.

  ## Examples

      iex> change_fee_arrear(fee_arrear)
      %Ecto.Changeset{data: %FeeArrear{}}

  """
  def change_fee_arrear(%FeeArrear{} = fee_arrear, attrs \\ %{}) do
    FeeArrear.changeset(fee_arrear, attrs)
  end
end
