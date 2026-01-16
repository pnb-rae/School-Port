defmodule Liveschool.Repo.Migrations.CreateFeeWaivers do
  use Ecto.Migration

  def change do
    create table(:fee_waivers) do
      add :waiver_type, :string
      add :amount_or_percentage, :decimal
      add :reason, :text
      add :academic_year, :string
      add :term, :string
      add :student_id, references(:students, on_delete: :nothing)
      add :fee_structure_id, references(:fee_structures, on_delete: :nothing)
      add :approved_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:fee_waivers, [:student_id])
    create index(:fee_waivers, [:fee_structure_id])
    create index(:fee_waivers, [:approved_by])
    create index(:fee_waivers, [:school_id])
  end
end
