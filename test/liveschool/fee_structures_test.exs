defmodule Liveschool.FeeStructuresTest do
  use Liveschool.DataCase

  alias Liveschool.FeeStructures

  describe "fee_structures" do
    alias Liveschool.FeeStructures.FeeStructure

    import Liveschool.FeeStructuresFixtures

    @invalid_attrs %{name: nil, term: nil, amount: nil, fee_type: nil, payment_frequency: nil, academic_year: nil, is_mandatory: nil}

    test "list_fee_structures/0 returns all fee_structures" do
      fee_structure = fee_structure_fixture()
      assert FeeStructures.list_fee_structures() == [fee_structure]
    end

    test "get_fee_structure!/1 returns the fee_structure with given id" do
      fee_structure = fee_structure_fixture()
      assert FeeStructures.get_fee_structure!(fee_structure.id) == fee_structure
    end

    test "create_fee_structure/1 with valid data creates a fee_structure" do
      valid_attrs = %{name: "some name", term: "some term", amount: "120.5", fee_type: "some fee_type", payment_frequency: "some payment_frequency", academic_year: "some academic_year", is_mandatory: true}

      assert {:ok, %FeeStructure{} = fee_structure} = FeeStructures.create_fee_structure(valid_attrs)
      assert fee_structure.name == "some name"
      assert fee_structure.term == "some term"
      assert fee_structure.amount == Decimal.new("120.5")
      assert fee_structure.fee_type == "some fee_type"
      assert fee_structure.payment_frequency == "some payment_frequency"
      assert fee_structure.academic_year == "some academic_year"
      assert fee_structure.is_mandatory == true
    end

    test "create_fee_structure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FeeStructures.create_fee_structure(@invalid_attrs)
    end

    test "update_fee_structure/2 with valid data updates the fee_structure" do
      fee_structure = fee_structure_fixture()
      update_attrs = %{name: "some updated name", term: "some updated term", amount: "456.7", fee_type: "some updated fee_type", payment_frequency: "some updated payment_frequency", academic_year: "some updated academic_year", is_mandatory: false}

      assert {:ok, %FeeStructure{} = fee_structure} = FeeStructures.update_fee_structure(fee_structure, update_attrs)
      assert fee_structure.name == "some updated name"
      assert fee_structure.term == "some updated term"
      assert fee_structure.amount == Decimal.new("456.7")
      assert fee_structure.fee_type == "some updated fee_type"
      assert fee_structure.payment_frequency == "some updated payment_frequency"
      assert fee_structure.academic_year == "some updated academic_year"
      assert fee_structure.is_mandatory == false
    end

    test "update_fee_structure/2 with invalid data returns error changeset" do
      fee_structure = fee_structure_fixture()
      assert {:error, %Ecto.Changeset{}} = FeeStructures.update_fee_structure(fee_structure, @invalid_attrs)
      assert fee_structure == FeeStructures.get_fee_structure!(fee_structure.id)
    end

    test "delete_fee_structure/1 deletes the fee_structure" do
      fee_structure = fee_structure_fixture()
      assert {:ok, %FeeStructure{}} = FeeStructures.delete_fee_structure(fee_structure)
      assert_raise Ecto.NoResultsError, fn -> FeeStructures.get_fee_structure!(fee_structure.id) end
    end

    test "change_fee_structure/1 returns a fee_structure changeset" do
      fee_structure = fee_structure_fixture()
      assert %Ecto.Changeset{} = FeeStructures.change_fee_structure(fee_structure)
    end
  end
end
