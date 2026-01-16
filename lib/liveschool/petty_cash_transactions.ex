defmodule Liveschool.PettyCashTransactions do
  @moduledoc """
  The PettyCashTransactions context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.PettyCashTransactions.PettyCashTransaction

  @doc """
  Returns the list of petty_cash_transactions.

  ## Examples

      iex> list_petty_cash_transactions()
      [%PettyCashTransaction{}, ...]

  """
  def list_petty_cash_transactions do
    Repo.all(PettyCashTransaction)
  end

  @doc """
  Gets a single petty_cash_transaction.

  Raises `Ecto.NoResultsError` if the Petty cash transaction does not exist.

  ## Examples

      iex> get_petty_cash_transaction!(123)
      %PettyCashTransaction{}

      iex> get_petty_cash_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_petty_cash_transaction!(id), do: Repo.get!(PettyCashTransaction, id)

  @doc """
  Creates a petty_cash_transaction.

  ## Examples

      iex> create_petty_cash_transaction(%{field: value})
      {:ok, %PettyCashTransaction{}}

      iex> create_petty_cash_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_petty_cash_transaction(attrs \\ %{}) do
    %PettyCashTransaction{}
    |> PettyCashTransaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a petty_cash_transaction.

  ## Examples

      iex> update_petty_cash_transaction(petty_cash_transaction, %{field: new_value})
      {:ok, %PettyCashTransaction{}}

      iex> update_petty_cash_transaction(petty_cash_transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_petty_cash_transaction(%PettyCashTransaction{} = petty_cash_transaction, attrs) do
    petty_cash_transaction
    |> PettyCashTransaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a petty_cash_transaction.

  ## Examples

      iex> delete_petty_cash_transaction(petty_cash_transaction)
      {:ok, %PettyCashTransaction{}}

      iex> delete_petty_cash_transaction(petty_cash_transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_petty_cash_transaction(%PettyCashTransaction{} = petty_cash_transaction) do
    Repo.delete(petty_cash_transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking petty_cash_transaction changes.

  ## Examples

      iex> change_petty_cash_transaction(petty_cash_transaction)
      %Ecto.Changeset{data: %PettyCashTransaction{}}

  """
  def change_petty_cash_transaction(%PettyCashTransaction{} = petty_cash_transaction, attrs \\ %{}) do
    PettyCashTransaction.changeset(petty_cash_transaction, attrs)
  end
end
