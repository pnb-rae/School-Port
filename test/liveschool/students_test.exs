defmodule Liveschool.StudentsTest do
  use Liveschool.DataCase

  alias Liveschool.Students

  describe "students" do
    alias Liveschool.Students.Student

    import Liveschool.StudentsFixtures

    @invalid_attrs %{status: nil, address: nil, admission_number: nil, first_name: nil, middle_name: nil, last_name: nil, date_of_birth: nil, gender: nil, photo_url: nil, parent_guardian_name: nil, parent_guardian_phone: nil, parent_guardian_email: nil, admission_date: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Students.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Students.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{status: "some status", address: "some address", admission_number: "some admission_number", first_name: "some first_name", middle_name: "some middle_name", last_name: "some last_name", date_of_birth: ~D[2025-12-10], gender: "some gender", photo_url: "some photo_url", parent_guardian_name: "some parent_guardian_name", parent_guardian_phone: "some parent_guardian_phone", parent_guardian_email: "some parent_guardian_email", admission_date: ~D[2025-12-10]}

      assert {:ok, %Student{} = student} = Students.create_student(valid_attrs)
      assert student.status == "some status"
      assert student.address == "some address"
      assert student.admission_number == "some admission_number"
      assert student.first_name == "some first_name"
      assert student.middle_name == "some middle_name"
      assert student.last_name == "some last_name"
      assert student.date_of_birth == ~D[2025-12-10]
      assert student.gender == "some gender"
      assert student.photo_url == "some photo_url"
      assert student.parent_guardian_name == "some parent_guardian_name"
      assert student.parent_guardian_phone == "some parent_guardian_phone"
      assert student.parent_guardian_email == "some parent_guardian_email"
      assert student.admission_date == ~D[2025-12-10]
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Students.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{status: "some updated status", address: "some updated address", admission_number: "some updated admission_number", first_name: "some updated first_name", middle_name: "some updated middle_name", last_name: "some updated last_name", date_of_birth: ~D[2025-12-11], gender: "some updated gender", photo_url: "some updated photo_url", parent_guardian_name: "some updated parent_guardian_name", parent_guardian_phone: "some updated parent_guardian_phone", parent_guardian_email: "some updated parent_guardian_email", admission_date: ~D[2025-12-11]}

      assert {:ok, %Student{} = student} = Students.update_student(student, update_attrs)
      assert student.status == "some updated status"
      assert student.address == "some updated address"
      assert student.admission_number == "some updated admission_number"
      assert student.first_name == "some updated first_name"
      assert student.middle_name == "some updated middle_name"
      assert student.last_name == "some updated last_name"
      assert student.date_of_birth == ~D[2025-12-11]
      assert student.gender == "some updated gender"
      assert student.photo_url == "some updated photo_url"
      assert student.parent_guardian_name == "some updated parent_guardian_name"
      assert student.parent_guardian_phone == "some updated parent_guardian_phone"
      assert student.parent_guardian_email == "some updated parent_guardian_email"
      assert student.admission_date == ~D[2025-12-11]
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Students.update_student(student, @invalid_attrs)
      assert student == Students.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Students.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Students.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Students.change_student(student)
    end
  end
end
