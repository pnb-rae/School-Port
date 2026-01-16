defmodule Liveschool.Repo.Migrations.CreateStudentFeeAllocations do
  use Ecto.Migration

  def change do
    create table(:student_fee_allocations) do
      add :amount_due, :decimal
      add :amount_paid, :decimal
      add :balance, :decimal
      add :status, :string
      add :due_date, :date
      add :academic_year, :string
      add :term, :string
      add :student_id, references(:students, on_delete: :nothing)
      add :fee_structure_id, references(:fee_structures, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:student_fee_allocations, [:student_id])
    create index(:student_fee_allocations, [:fee_structure_id])
  end
end
