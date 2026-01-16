defmodule Liveschool.FeeArrearsTest do
  use Liveschool.DataCase

  alias Liveschool.FeeArrears

  describe "fee_arrears" do
    alias Liveschool.FeeArrears.FeeArrear

    import Liveschool.FeeArrearsFixtures

    @invalid_attrs %{status: nil, term: nil, amount: nil, academic_year: nil, notes: nil}

    test "list_fee_arrears/0 returns all fee_arrears" do
      fee_arrear = fee_arrear_fixture()
      assert FeeArrears.list_fee_arrears() == [fee_arrear]
    end

    test "get_fee_arrear!/1 returns the fee_arrear with given id" do
      fee_arrear = fee_arrear_fixture()
      assert FeeArrears.get_fee_arrear!(fee_arrear.id) == fee_arrear
    end

    test "create_fee_arrear/1 with valid data creates a fee_arrear" do
      valid_attrs = %{status: "some status", term: "some term", amount: "120.5", academic_year: "some academic_year", notes: "some notes"}

      assert {:ok, %FeeArrear{} = fee_arrear} = FeeArrears.create_fee_arrear(valid_attrs)
      assert fee_arrear.status == "some status"
      assert fee_arrear.term == "some term"
      assert fee_arrear.amount == Decimal.new("120.5")
      assert fee_arrear.academic_year == "some academic_year"
      assert fee_arrear.notes == "some notes"
    end

    test "create_fee_arrear/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeeArrears.create_fee_arrear(@invalid_attrs)
    end

    test "update_fee_arrear/2 with valid data updates the fee_arrear" do
      fee_arrear = fee_arrear_fixture()
      update_attrs = %{status: "some updated status", term: "some updated term", amount: "456.7", academic_year: "some updated academic_year", notes: "some updated notes"}

      assert {:ok, %FeeArrear{} = fee_arrear} = FeeArrears.update_fee_arrear(fee_arrear, update_attrs)
      assert fee_arrear.status == "some updated status"
      assert fee_arrear.term == "some updated term"
      assert fee_arrear.amount == Decimal.new("456.7")
      assert fee_arrear.academic_year == "some updated academic_year"
      assert fee_arrear.notes == "some updated notes"
    end

    test "update_fee_arrear/2 with invalid data returns error changeset" do
      fee_arrear = fee_arrear_fixture()
      assert {:error, %Ecto.Changeset{}} = FeeArrears.update_fee_arrear(fee_arrear, @invalid_attrs)
      assert fee_arrear == FeeArrears.get_fee_arrear!(fee_arrear.id)
    end

    test "delete_fee_arrear/1 deletes the fee_arrear" do
      fee_arrear = fee_arrear_fixture()
      assert {:ok, %FeeArrear{}} = FeeArrears.delete_fee_arrear(fee_arrear)
      assert_raise Ecto.NoResultsError, fn -> FeeArrears.get_fee_arrear!(fee_arrear.id) end
    end

    test "change_fee_arrear/1 returns a fee_arrear changeset" do
      fee_arrear = fee_arrear_fixture()
      assert %Ecto.Changeset{} = FeeArrears.change_fee_arrear(fee_arrear)
    end
  end
end
