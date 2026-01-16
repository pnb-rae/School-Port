defmodule Liveschool.SchoolAssets do
  @moduledoc """
  The SchoolAssets context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.SchoolAssets.SchoolAsset

  @doc """
  Returns the list of school_assets.

  ## Examples

      iex> list_school_assets()
      [%SchoolAsset{}, ...]

  """
  def list_school_assets do
    Repo.all(SchoolAsset)
  end

  @doc """
  Gets a single school_asset.

  Raises `Ecto.NoResultsError` if the School asset does not exist.

  ## Examples

      iex> get_school_asset!(123)
      %SchoolAsset{}

      iex> get_school_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_school_asset!(id), do: Repo.get!(SchoolAsset, id)

  @doc """
  Creates a school_asset.

  ## Examples

      iex> create_school_asset(%{field: value})
      {:ok, %SchoolAsset{}}

      iex> create_school_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_school_asset(attrs \\ %{}) do
    %SchoolAsset{}
    |> SchoolAsset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a school_asset.

  ## Examples

      iex> update_school_asset(school_asset, %{field: new_value})
      {:ok, %SchoolAsset{}}

      iex> update_school_asset(school_asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_school_asset(%SchoolAsset{} = school_asset, attrs) do
    school_asset
    |> SchoolAsset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a school_asset.

  ## Examples

      iex> delete_school_asset(school_asset)
      {:ok, %SchoolAsset{}}

      iex> delete_school_asset(school_asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_school_asset(%SchoolAsset{} = school_asset) do
    Repo.delete(school_asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking school_asset changes.

  ## Examples

      iex> change_school_asset(school_asset)
      %Ecto.Changeset{data: %SchoolAsset{}}

  """
  def change_school_asset(%SchoolAsset{} = school_asset, attrs \\ %{}) do
    SchoolAsset.changeset(school_asset, attrs)
  end
end
