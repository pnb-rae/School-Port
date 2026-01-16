defmodule Liveschool.DepartmentsTest do
  use Liveschool.DataCase

  alias Liveschool.Departments

  describe "departments" do
    alias Liveschool.Departments.Department

    import Liveschool.DepartmentsFixtures

    @invalid_attrs %{code: nil, name: nil, budget_allocation: nil}

    test "list_departments/0 returns all departments" do
      department = department_fixture()
      assert Departments.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      department = department_fixture()
      assert Departments.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      valid_attrs = %{code: "some code", name: "some name", budget_allocation: "120.5"}

      assert {:ok, %Department{} = department} = Departments.create_department(valid_attrs)
      assert department.code == "some code"
      assert department.name == "some name"
      assert department.budget_allocation == Decimal.new("120.5")
    end

    test "create_department/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Departments.create_department(@invalid_attrs)
    end

    test "update_department/2 with valid data updates the department" do
      department = department_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name", budget_allocation: "456.7"}

      assert {:ok, %Department{} = department} = Departments.update_department(department, update_attrs)
      assert department.code == "some updated code"
      assert department.name == "some updated name"
      assert department.budget_allocation == Decimal.new("456.7")
    end

    test "update_department/2 with invalid data returns error changeset" do
      department = department_fixture()
      assert {:error, %Ecto.Changeset{}} = Departments.update_department(department, @invalid_attrs)
      assert department == Departments.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      department = department_fixture()
      assert {:ok, %Department{}} = Departments.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Departments.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      department = department_fixture()
      assert %Ecto.Changeset{} = Departments.change_department(department)
    end
  end
end
