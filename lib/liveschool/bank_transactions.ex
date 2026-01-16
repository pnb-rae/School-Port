defmodule Liveschool.BankTransactions do
  @moduledoc """
  The BankTransactions context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.BankTransactions.BankTransaction

  @doc """
  Returns the list of bank_transactions.

  ## Examples

      iex> list_bank_transactions()
      [%BankTransaction{}, ...]

  """
  def list_bank_transactions do
    Repo.all(BankTransaction)
  end

  @doc """
  Gets a single bank_transaction.

  Raises `Ecto.NoResultsError` if the Bank transaction does not exist.

  ## Examples

      iex> get_bank_transaction!(123)
      %BankTransaction{}

      iex> get_bank_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bank_transaction!(id), do: Repo.get!(BankTransaction, id)

  @doc """
  Creates a bank_transaction.

  ## Examples

      iex> create_bank_transaction(%{field: value})
      {:ok, %BankTransaction{}}

      iex> create_bank_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bank_transaction(attrs \\ %{}) do
    %BankTransaction{}
    |> BankTransaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bank_transaction.

  ## Examples

      iex> update_bank_transaction(bank_transaction, %{field: new_value})
      {:ok, %BankTransaction{}}

      iex> update_bank_transaction(bank_transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bank_transaction(%BankTransaction{} = bank_transaction, attrs) do
    bank_transaction
    |> BankTransaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bank_transaction.

  ## Examples

      iex> delete_bank_transaction(bank_transaction)
      {:ok, %BankTransaction{}}

      iex> delete_bank_transaction(bank_transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bank_transaction(%BankTransaction{} = bank_transaction) do
    Repo.delete(bank_transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bank_transaction changes.

  ## Examples

      iex> change_bank_transaction(bank_transaction)
      %Ecto.Changeset{data: %BankTransaction{}}

  """
  def change_bank_transaction(%BankTransaction{} = bank_transaction, attrs \\ %{}) do
    BankTransaction.changeset(bank_transaction, attrs)
  end
end
