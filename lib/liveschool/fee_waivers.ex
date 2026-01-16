defmodule Liveschool.FeeWaivers do
  @moduledoc """
  The FeeWaivers context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.FeeWaivers.FeeWaiver

  @doc """
  Returns the list of fee_waivers.

  ## Examples

      iex> list_fee_waivers()
      [%FeeWaiver{}, ...]

  """
  def list_fee_waivers do
    Repo.all(FeeWaiver)
  end

  @doc """
  Gets a single fee_waiver.

  Raises `Ecto.NoResultsError` if the Fee waiver does not exist.

  ## Examples

      iex> get_fee_waiver!(123)
      %FeeWaiver{}

      iex> get_fee_waiver!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fee_waiver!(id), do: Repo.get!(FeeWaiver, id)

  @doc """
  Creates a fee_waiver.

  ## Examples

      iex> create_fee_waiver(%{field: value})
      {:ok, %FeeWaiver{}}

      iex> create_fee_waiver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fee_waiver(attrs \\ %{}) do
    %FeeWaiver{}
    |> FeeWaiver.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fee_waiver.

  ## Examples

      iex> update_fee_waiver(fee_waiver, %{field: new_value})
      {:ok, %FeeWaiver{}}

      iex> update_fee_waiver(fee_waiver, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fee_waiver(%FeeWaiver{} = fee_waiver, attrs) do
    fee_waiver
    |> FeeWaiver.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fee_waiver.

  ## Examples

      iex> delete_fee_waiver(fee_waiver)
      {:ok, %FeeWaiver{}}

      iex> delete_fee_waiver(fee_waiver)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fee_waiver(%FeeWaiver{} = fee_waiver) do
    Repo.delete(fee_waiver)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fee_waiver changes.

  ## Examples

      iex> change_fee_waiver(fee_waiver)
      %Ecto.Changeset{data: %FeeWaiver{}}

  """
  def change_fee_waiver(%FeeWaiver{} = fee_waiver, attrs \\ %{}) do
    FeeWaiver.changeset(fee_waiver, attrs)
  end
end
