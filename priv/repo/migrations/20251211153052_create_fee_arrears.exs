defmodule Liveschool.Repo.Migrations.CreateFeeArrears do
  use Ecto.Migration

  def change do
    create table(:fee_arrears) do
      add :amount, :decimal
      add :academic_year, :string
      add :term, :string
      add :notes, :text
      add :status, :string
      add :student_id, references(:students, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:fee_arrears, [:student_id])
    create index(:fee_arrears, [:school_id])
  end
end
