defmodule Liveschool.Staff.StaffMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "staff_members" do
    field :position, :string
    field :status, :string
    field :staff_number, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :email, :string
    field :date_of_birth, :date
    field :hire_date, :date
    field :salary, :decimal
    field :account_number, :string
    field :user_id, :id
    field :department_id, :id
    field :bank_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(staff_member, attrs) do
    staff_member
    |> cast(attrs, [:staff_number, :first_name, :last_name, :phone, :email, :date_of_birth, :hire_date, :position, :salary, :account_number, :status])
    |> validate_required([:staff_number, :first_name, :last_name, :phone, :email, :date_of_birth, :hire_date, :position, :salary, :account_number, :status])
    |> unique_constraint(:staff_number)
  end
end
