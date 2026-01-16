defmodule Liveschool.FeeReceiptItems do
  @moduledoc """
  The FeeReceiptItems context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.FeeReceiptItems.FeeReceiptItem

  @doc """
  Returns the list of fee_receipt_items.

  ## Examples

      iex> list_fee_receipt_items()
      [%FeeReceiptItem{}, ...]

  """
  def list_fee_receipt_items do
    Repo.all(FeeReceiptItem)
  end

  @doc """
  Gets a single fee_receipt_item.

  Raises `Ecto.NoResultsError` if the Fee receipt item does not exist.

  ## Examples

      iex> get_fee_receipt_item!(123)
      %FeeReceiptItem{}

      iex> get_fee_receipt_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_receipt_item!(id), do: Repo.get!(FeeReceiptItem, id)

  @doc """
  Creates a fee_receipt_item.

  ## Examples

      iex> create_fee_receipt_item(%{field: value})
      {:ok, %FeeReceiptItem{}}

      iex> create_fee_receipt_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_receipt_item(attrs \\ %{}) do
    %FeeReceiptItem{}
    |> FeeReceiptItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_receipt_item.

  ## Examples

      iex> update_fee_receipt_item(fee_receipt_item, %{field: new_value})
      {:ok, %FeeReceiptItem{}}

      iex> update_fee_receipt_item(fee_receipt_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_receipt_item(%FeeReceiptItem{} = fee_receipt_item, attrs) do
    fee_receipt_item
    |> FeeReceiptItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_receipt_item.

  ## Examples

      iex> delete_fee_receipt_item(fee_receipt_item)
      {:ok, %FeeReceiptItem{}}

      iex> delete_fee_receipt_item(fee_receipt_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_receipt_item(%FeeReceiptItem{} = fee_receipt_item) do
    Repo.delete(fee_receipt_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_receipt_item changes.

  ## Examples

      iex> change_fee_receipt_item(fee_receipt_item)
      %Ecto.Changeset{data: %FeeReceiptItem{}}

  """
  def change_fee_receipt_item(%FeeReceiptItem{} = fee_receipt_item, attrs \\ %{}) do
    FeeReceiptItem.changeset(fee_receipt_item, attrs)
  end
end
