defmodule Liveschool.FeeReceipts do
  @moduledoc """
  The FeeReceipts context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.FeeReceipts.FeeReceipt

  @doc """
  Returns the list of fee_receipts.

  ## Examples

      iex> list_fee_receipts()
      [%FeeReceipt{}, ...]

  """
  def list_fee_receipts do
    Repo.all(FeeReceipt)
  end

  @doc """
  Gets a single fee_receipt.

  Raises `Ecto.NoResultsError` if the Fee receipt does not exist.

  ## Examples

      iex> get_fee_receipt!(123)
      %FeeReceipt{}

      iex> get_fee_receipt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_receipt!(id), do: Repo.get!(FeeReceipt, id)

  @doc """
  Creates a fee_receipt.

  ## Examples

      iex> create_fee_receipt(%{field: value})
      {:ok, %FeeReceipt{}}

      iex> create_fee_receipt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_receipt(attrs \\ %{}) do
    %FeeReceipt{}
    |> FeeReceipt.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_receipt.

  ## Examples

      iex> update_fee_receipt(fee_receipt, %{field: new_value})
      {:ok, %FeeReceipt{}}

      iex> update_fee_receipt(fee_receipt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_receipt(%FeeReceipt{} = fee_receipt, attrs) do
    fee_receipt
    |> FeeReceipt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_receipt.

  ## Examples

      iex> delete_fee_receipt(fee_receipt)
      {:ok, %FeeReceipt{}}

      iex> delete_fee_receipt(fee_receipt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_receipt(%FeeReceipt{} = fee_receipt) do
    Repo.delete(fee_receipt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_receipt changes.

  ## Examples

      iex> change_fee_receipt(fee_receipt)
      %Ecto.Changeset{data: %FeeReceipt{}}

  """
  def change_fee_receipt(%FeeReceipt{} = fee_receipt, attrs \\ %{}) do
    FeeReceipt.changeset(fee_receipt, attrs)
  end
end
