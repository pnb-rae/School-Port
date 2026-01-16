defmodule Liveschool.PocketMoneyTransactions do
  @moduledoc """
  The PocketMoneyTransactions context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.PocketMoneyTransactions.PocketMoneyTransaction

  @doc """
  Returns the list of pocket_money_transactions.

  ## Examples

      iex> list_pocket_money_transactions()
      [%PocketMoneyTransaction{}, ...]

  """
  def list_pocket_money_transactions do
    Repo.all(PocketMoneyTransaction)
  end

  @doc """
  Gets a single pocket_money_transaction.

  Raises `Ecto.NoResultsError` if the Pocket money transaction does not exist.

  ## Examples

      iex> get_pocket_money_transaction!(123)
      %PocketMoneyTransaction{}

      iex> get_pocket_money_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pocket_money_transaction!(id), do: Repo.get!(PocketMoneyTransaction, id)

  @doc """
  Creates a pocket_money_transaction.

  ## Examples

      iex> create_pocket_money_transaction(%{field: value})
      {:ok, %PocketMoneyTransaction{}}

      iex> create_pocket_money_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pocket_money_transaction(attrs \\ %{}) do
    %PocketMoneyTransaction{}
    |> PocketMoneyTransaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pocket_money_transaction.

  ## Examples

      iex> update_pocket_money_transaction(pocket_money_transaction, %{field: new_value})
      {:ok, %PocketMoneyTransaction{}}

      iex> update_pocket_money_transaction(pocket_money_transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pocket_money_transaction(%PocketMoneyTransaction{} = pocket_money_transaction, attrs) do
    pocket_money_transaction
    |> PocketMoneyTransaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pocket_money_transaction.

  ## Examples

      iex> delete_pocket_money_transaction(pocket_money_transaction)
      {:ok, %PocketMoneyTransaction{}}

      iex> delete_pocket_money_transaction(pocket_money_transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pocket_money_transaction(%PocketMoneyTransaction{} = pocket_money_transaction) do
    Repo.delete(pocket_money_transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pocket_money_transaction changes.

  ## Examples

      iex> change_pocket_money_transaction(pocket_money_transaction)
      %Ecto.Changeset{data: %PocketMoneyTransaction{}}

  """
  def change_pocket_money_transaction(%PocketMoneyTransaction{} = pocket_money_transaction, attrs \\ %{}) do
    PocketMoneyTransaction.changeset(pocket_money_transaction, attrs)
  end
end
