defmodule Liveschool.SchoolAssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.SchoolAssets` context.
  """

  @doc """
  Generate a unique school_asset asset_number.
  """
  def unique_school_asset_asset_number, do: "some asset_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a school_asset.
  """
  def school_asset_fixture(attrs \\ %{}) do
    {:ok, school_asset} =
      attrs
      |> Enum.into(%{
        asset_number: unique_school_asset_asset_number(),
        category: "some category",
        condition: "some condition",
        current_value: "120.5",
        depreciation_rate: "120.5",
        location: "some location",
        name: "some name",
        purchase_date: ~D[2025-12-10],
        purchase_price: "120.5"
      })
      |> Liveschool.SchoolAssets.create_school_asset()

    school_asset
  end
end
