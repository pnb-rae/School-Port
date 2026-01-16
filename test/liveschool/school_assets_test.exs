defmodule Liveschool.SchoolAssetsTest do
  use Liveschool.DataCase

  alias Liveschool.SchoolAssets

  describe "school_assets" do
    alias Liveschool.SchoolAssets.SchoolAsset

    import Liveschool.SchoolAssetsFixtures

    @invalid_attrs %{name: nil, location: nil, category: nil, asset_number: nil, purchase_date: nil, purchase_price: nil, current_value: nil, depreciation_rate: nil, condition: nil}

    test "list_school_assets/0 returns all school_assets" do
      school_asset = school_asset_fixture()
      assert SchoolAssets.list_school_assets() == [school_asset]
    end

    test "get_school_asset!/1 returns the school_asset with given id" do
      school_asset = school_asset_fixture()
      assert SchoolAssets.get_school_asset!(school_asset.id) == school_asset
    end

    test "create_school_asset/1 with valid data creates a school_asset" do
      valid_attrs = %{name: "some name", location: "some location", category: "some category", asset_number: "some asset_number", purchase_date: ~D[2025-12-10], purchase_price: "120.5", current_value: "120.5", depreciation_rate: "120.5", condition: "some condition"}

      assert {:ok, %SchoolAsset{} = school_asset} = SchoolAssets.create_school_asset(valid_attrs)
      assert school_asset.name == "some name"
      assert school_asset.location == "some location"
      assert school_asset.category == "some category"
      assert school_asset.asset_number == "some asset_number"
      assert school_asset.purchase_date == ~D[2025-12-10]
      assert school_asset.purchase_price == Decimal.new("120.5")
      assert school_asset.current_value == Decimal.new("120.5")
      assert school_asset.depreciation_rate == Decimal.new("120.5")
      assert school_asset.condition == "some condition"
    end

    test "create_school_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SchoolAssets.create_school_asset(@invalid_attrs)
    end

    test "update_school_asset/2 with valid data updates the school_asset" do
      school_asset = school_asset_fixture()
      update_attrs = %{name: "some updated name", location: "some updated location", category: "some updated category", asset_number: "some updated asset_number", purchase_date: ~D[2025-12-11], purchase_price: "456.7", current_value: "456.7", depreciation_rate: "456.7", condition: "some updated condition"}

      assert {:ok, %SchoolAsset{} = school_asset} = SchoolAssets.update_school_asset(school_asset, update_attrs)
      assert school_asset.name == "some updated name"
      assert school_asset.location == "some updated location"
      assert school_asset.category == "some updated category"
      assert school_asset.asset_number == "some updated asset_number"
      assert school_asset.purchase_date == ~D[2025-12-11]
      assert school_asset.purchase_price == Decimal.new("456.7")
      assert school_asset.current_value == Decimal.new("456.7")
      assert school_asset.depreciation_rate == Decimal.new("456.7")
      assert school_asset.condition == "some updated condition"
    end

    test "update_school_asset/2 with invalid data returns error changeset" do
      school_asset = school_asset_fixture()
      assert {:error, %Ecto.Changeset{}} = SchoolAssets.update_school_asset(school_asset, @invalid_attrs)
      assert school_asset == SchoolAssets.get_school_asset!(school_asset.id)
    end

    test "delete_school_asset/1 deletes the school_asset" do
      school_asset = school_asset_fixture()
      assert {:ok, %SchoolAsset{}} = SchoolAssets.delete_school_asset(school_asset)
      assert_raise Ecto.NoResultsError, fn -> SchoolAssets.get_school_asset!(school_asset.id) end
    end

    test "change_school_asset/1 returns a school_asset changeset" do
      school_asset = school_asset_fixture()
      assert %Ecto.Changeset{} = SchoolAssets.change_school_asset(school_asset)
    end
  end
end
