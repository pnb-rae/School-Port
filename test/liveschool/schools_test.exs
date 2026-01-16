defmodule Liveschool.SchoolsTest do
  use Liveschool.DataCase

  alias Liveschool.Schools

  describe "schools" do
    alias Liveschool.Schools.School

    import Liveschool.SchoolsFixtures

    @invalid_attrs %{code: nil, name: nil, address: nil, phone: nil, email: nil, logo_url: nil, established_date: nil, current_academic_year: nil, settings: nil}

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Schools.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Schools.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      valid_attrs = %{code: "some code", name: "some name", address: "some address", phone: "some phone", email: "some email", logo_url: "some logo_url", established_date: ~D[2025-12-10], current_academic_year: "some current_academic_year", settings: %{}}

      assert {:ok, %School{} = school} = Schools.create_school(valid_attrs)
      assert school.code == "some code"
      assert school.name == "some name"
      assert school.address == "some address"
      assert school.phone == "some phone"
      assert school.email == "some email"
      assert school.logo_url == "some logo_url"
      assert school.established_date == ~D[2025-12-10]
      assert school.current_academic_year == "some current_academic_year"
      assert school.settings == %{}
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schools.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name", address: "some updated address", phone: "some updated phone", email: "some updated email", logo_url: "some updated logo_url", established_date: ~D[2025-12-11], current_academic_year: "some updated current_academic_year", settings: %{}}

      assert {:ok, %School{} = school} = Schools.update_school(school, update_attrs)
      assert school.code == "some updated code"
      assert school.name == "some updated name"
      assert school.address == "some updated address"
      assert school.phone == "some updated phone"
      assert school.email == "some updated email"
      assert school.logo_url == "some updated logo_url"
      assert school.established_date == ~D[2025-12-11]
      assert school.current_academic_year == "some updated current_academic_year"
      assert school.settings == %{}
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Schools.update_school(school, @invalid_attrs)
      assert school == Schools.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Schools.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Schools.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Schools.change_school(school)
    end
  end
end
