defmodule Liveschool.StudentFeeAllocationsTest do
  use Liveschool.DataCase

  alias Liveschool.StudentFeeAllocations

  describe "student_fee_allocations" do
    alias Liveschool.StudentFeeAllocations.StudentFeeAllocation

    import Liveschool.StudentFeeAllocationsFixtures

    @invalid_attrs %{status: nil, term: nil, balance: nil, amount_due: nil, amount_paid: nil, due_date: nil, academic_year: nil}

    test "list_student_fee_allocations/0 returns all student_fee_allocations" do
      student_fee_allocation = student_fee_allocation_fixture()
      assert StudentFeeAllocations.list_student_fee_allocations() == [student_fee_allocation]
    end

    test "get_student_fee_allocation!/1 returns the student_fee_allocation with given id" do
      student_fee_allocation = student_fee_allocation_fixture()
      assert StudentFeeAllocations.get_student_fee_allocation!(student_fee_allocation.id) == student_fee_allocation
    end

    test "create_student_fee_allocation/1 with valid data creates a student_fee_allocation" do
      valid_attrs = %{status: "some status", term: "some term", balance: "120.5", amount_due: "120.5", amount_paid: "120.5", due_date: ~D[2025-12-10], academic_year: "some academic_year"}

      assert {:ok, %StudentFeeAllocation{} = student_fee_allocation} = StudentFeeAllocations.create_student_fee_allocation(valid_attrs)
      assert student_fee_allocation.status == "some status"
      assert student_fee_allocation.term == "some term"
      assert student_fee_allocation.balance == Decimal.new("120.5")
      assert student_fee_allocation.amount_due == Decimal.new("120.5")
      assert student_fee_allocation.amount_paid == Decimal.new("120.5")
      assert student_fee_allocation.due_date == ~D[2025-12-10]
      assert student_fee_allocation.academic_year == "some academic_year"
    end

    test "create_student_fee_allocation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = StudentFeeAllocations.create_student_fee_allocation(@invalid_attrs)
    end

    test "update_student_fee_allocation/2 with valid data updates the student_fee_allocation" do
      student_fee_allocation = student_fee_allocation_fixture()
      update_attrs = %{status: "some updated status", term: "some updated term", balance: "456.7", amount_due: "456.7", amount_paid: "456.7", due_date: ~D[2025-12-11], academic_year: "some updated academic_year"}

      assert {:ok, %StudentFeeAllocation{} = student_fee_allocation} = StudentFeeAllocations.update_student_fee_allocation(student_fee_allocation, update_attrs)
      assert student_fee_allocation.status == "some updated status"
      assert student_fee_allocation.term == "some updated term"
      assert student_fee_allocation.balance == Decimal.new("456.7")
      assert student_fee_allocation.amount_due == Decimal.new("456.7")
      assert student_fee_allocation.amount_paid == Decimal.new("456.7")
      assert student_fee_allocation.due_date == ~D[2025-12-11]
      assert student_fee_allocation.academic_year == "some updated academic_year"
    end

    test "update_student_fee_allocation/2 with invalid data returns error changeset" do
      student_fee_allocation = student_fee_allocation_fixture()
      assert {:error, %Ecto.Changeset{}} = StudentFeeAllocations.update_student_fee_allocation(student_fee_allocation, @invalid_attrs)
      assert student_fee_allocation == StudentFeeAllocations.get_student_fee_allocation!(student_fee_allocation.id)
    end

    test "delete_student_fee_allocation/1 deletes the student_fee_allocation" do
      student_fee_allocation = student_fee_allocation_fixture()
      assert {:ok, %StudentFeeAllocation{}} = StudentFeeAllocations.delete_student_fee_allocation(student_fee_allocation)
      assert_raise Ecto.NoResultsError, fn -> StudentFeeAllocations.get_student_fee_allocation!(student_fee_allocation.id) end
    end

    test "change_student_fee_allocation/1 returns a student_fee_allocation changeset" do
      student_fee_allocation = student_fee_allocation_fixture()
      assert %Ecto.Changeset{} = StudentFeeAllocations.change_student_fee_allocation(student_fee_allocation)
    end
  end
end
