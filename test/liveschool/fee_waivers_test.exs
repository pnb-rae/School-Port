defmodule Liveschool.FeeWaiversTest do
  use Liveschool.DataCase

  alias Liveschool.FeeWaivers

  describe "fee_waivers" do
    alias Liveschool.FeeWaivers.FeeWaiver

    import Liveschool.FeeWaiversFixtures

    @invalid_attrs %{reason: nil, term: nil, waiver_type: nil, amount_or_percentage: nil, academic_year: nil}

    test "list_fee_waivers/0 returns all fee_waivers" do
      fee_waiver = fee_waiver_fixture()
      assert FeeWaivers.list_fee_waivers() == [fee_waiver]
    end

    test "get_fee_waiver!/1 returns the fee_waiver with given id" do
      fee_waiver = fee_waiver_fixture()
      assert FeeWaivers.get_fee_waiver!(fee_waiver.id) == fee_waiver
    end

    test "create_fee_waiver/1 with valid data creates a fee_waiver" do
      valid_attrs = %{reason: "some reason", term: "some term", waiver_type: "some waiver_type", amount_or_percentage: "120.5", academic_year: "some academic_year"}

      assert {:ok, %FeeWaiver{} = fee_waiver} = FeeWaivers.create_fee_waiver(valid_attrs)
      assert fee_waiver.reason == "some reason"
      assert fee_waiver.term == "some term"
      assert fee_waiver.waiver_type == "some waiver_type"
      assert fee_waiver.amount_or_percentage == Decimal.new("120.5")
      assert fee_waiver.academic_year == "some academic_year"
    end

    test "create_fee_waiver/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeeWaivers.create_fee_waiver(@invalid_attrs)
    end

    test "update_fee_waiver/2 with valid data updates the fee_waiver" do
      fee_waiver = fee_waiver_fixture()
      update_attrs = %{reason: "some updated reason", term: "some updated term", waiver_type: "some updated waiver_type", amount_or_percentage: "456.7", academic_year: "some updated academic_year"}

      assert {:ok, %FeeWaiver{} = fee_waiver} = FeeWaivers.update_fee_waiver(fee_waiver, update_attrs)
      assert fee_waiver.reason == "some updated reason"
      assert fee_waiver.term == "some updated term"
      assert fee_waiver.waiver_type == "some updated waiver_type"
      assert fee_waiver.amount_or_percentage == Decimal.new("456.7")
      assert fee_waiver.academic_year == "some updated academic_year"
    end

    test "update_fee_waiver/2 with invalid data returns error changeset" do
      fee_waiver = fee_waiver_fixture()
      assert {:error, %Ecto.Changeset{}} = FeeWaivers.update_fee_waiver(fee_waiver, @invalid_attrs)
      assert fee_waiver == FeeWaivers.get_fee_waiver!(fee_waiver.id)
    end

    test "delete_fee_waiver/1 deletes the fee_waiver" do
      fee_waiver = fee_waiver_fixture()
      assert {:ok, %FeeWaiver{}} = FeeWaivers.delete_fee_waiver(fee_waiver)
      assert_raise Ecto.NoResultsError, fn -> FeeWaivers.get_fee_waiver!(fee_waiver.id) end
    end

    test "change_fee_waiver/1 returns a fee_waiver changeset" do
      fee_waiver = fee_waiver_fixture()
      assert %Ecto.Changeset{} = FeeWaivers.change_fee_waiver(fee_waiver)
    end
  end
end
