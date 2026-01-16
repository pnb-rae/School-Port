defmodule Liveschool.StudentFeeAllocations.StudentFeeAllocation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "student_fee_allocations" do
    field :status, :string
    field :term, :string
    field :balance, :decimal
    field :amount_due, :decimal
    field :amount_paid, :decimal
    field :due_date, :date
    field :academic_year, :string
    field :student_id, :id
    field :fee_structure_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student_fee_allocation, attrs) do
    student_fee_allocation
    |> cast(attrs, [:amount_due, :amount_paid, :balance, :status, :due_date, :academic_year, :term])
    |> validate_required([:amount_due, :amount_paid, :balance, :status, :due_date, :academic_year, :term])
  end
end
