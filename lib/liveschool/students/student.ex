defmodule Liveschool.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field :status, :string
    field :address, :string
    field :admission_number, :string
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string
    field :date_of_birth, :date
    field :gender, :string
    field :photo_url, :string
    field :parent_guardian_name, :string
    field :parent_guardian_phone, :string
    field :parent_guardian_email, :string
    field :admission_date, :date
    field :class_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:admission_number, :first_name, :middle_name, :last_name, :date_of_birth, :gender, :photo_url, :address, :parent_guardian_name, :parent_guardian_phone, :parent_guardian_email, :admission_date, :status])
    |> validate_required([:admission_number, :first_name, :middle_name, :last_name, :date_of_birth, :gender, :photo_url, :address, :parent_guardian_name, :parent_guardian_phone, :parent_guardian_email, :admission_date, :status])
    |> unique_constraint(:admission_number)
  end
end
