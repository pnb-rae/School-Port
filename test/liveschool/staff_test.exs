defmodule Liveschool.StaffTest do
  use Liveschool.DataCase

  alias Liveschool.Staff

  describe "staff_members" do
    alias Liveschool.Staff.StaffMember

    import Liveschool.StaffFixtures

    @invalid_attrs %{position: nil, status: nil, staff_number: nil, first_name: nil, last_name: nil, phone: nil, email: nil, date_of_birth: nil, hire_date: nil, salary: nil, account_number: nil}

    test "list_staff_members/0 returns all staff_members" do
      staff_member = staff_member_fixture()
      assert Staff.list_staff_members() == [staff_member]
    end

    test "get_staff_member!/1 returns the staff_member with given id" do
      staff_member = staff_member_fixture()
      assert Staff.get_staff_member!(staff_member.id) == staff_member
    end

    test "create_staff_member/1 with valid data creates a staff_member" do
      valid_attrs = %{position: "some position", status: "some status", staff_number: "some staff_number", first_name: "some first_name", last_name: "some last_name", phone: "some phone", email: "some email", date_of_birth: ~D[2025-12-10], hire_date: ~D[2025-12-10], salary: "120.5", account_number: "some account_number"}

      assert {:ok, %StaffMember{} = staff_member} = Staff.create_staff_member(valid_attrs)
      assert staff_member.position == "some position"
      assert staff_member.status == "some status"
      assert staff_member.staff_number == "some staff_number"
      assert staff_member.first_name == "some first_name"
      assert staff_member.last_name == "some last_name"
      assert staff_member.phone == "some phone"
      assert staff_member.email == "some email"
      assert staff_member.date_of_birth == ~D[2025-12-10]
      assert staff_member.hire_date == ~D[2025-12-10]
      assert staff_member.salary == Decimal.new("120.5")
      assert staff_member.account_number == "some account_number"
    end

    test "create_staff_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_staff_member(@invalid_attrs)
    end

    test "update_staff_member/2 with valid data updates the staff_member" do
      staff_member = staff_member_fixture()
      update_attrs = %{position: "some updated position", status: "some updated status", staff_number: "some updated staff_number", first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", email: "some updated email", date_of_birth: ~D[2025-12-11], hire_date: ~D[2025-12-11], salary: "456.7", account_number: "some updated account_number"}

      assert {:ok, %StaffMember{} = staff_member} = Staff.update_staff_member(staff_member, update_attrs)
      assert staff_member.position == "some updated position"
      assert staff_member.status == "some updated status"
      assert staff_member.staff_number == "some updated staff_number"
      assert staff_member.first_name == "some updated first_name"
      assert staff_member.last_name == "some updated last_name"
      assert staff_member.phone == "some updated phone"
      assert staff_member.email == "some updated email"
      assert staff_member.date_of_birth == ~D[2025-12-11]
      assert staff_member.hire_date == ~D[2025-12-11]
      assert staff_member.salary == Decimal.new("456.7")
      assert staff_member.account_number == "some updated account_number"
    end

    test "update_staff_member/2 with invalid data returns error changeset" do
      staff_member = staff_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_staff_member(staff_member, @invalid_attrs)
      assert staff_member == Staff.get_staff_member!(staff_member.id)
    end

    test "delete_staff_member/1 deletes the staff_member" do
      staff_member = staff_member_fixture()
      assert {:ok, %StaffMember{}} = Staff.delete_staff_member(staff_member)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_staff_member!(staff_member.id) end
    end

    test "change_staff_member/1 returns a staff_member changeset" do
      staff_member = staff_member_fixture()
      assert %Ecto.Changeset{} = Staff.change_staff_member(staff_member)
    end
  end
end
