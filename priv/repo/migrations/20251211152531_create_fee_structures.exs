defmodule Liveschool.Repo.Migrations.CreateFeeStructures do
  use Ecto.Migration

  def change do
    create table(:fee_structures) do
      add :name, :string
      add :amount, :decimal
      add :fee_type, :string
      add :payment_frequency, :string
      add :academic_year, :string
      add :term, :string
      add :is_mandatory, :boolean, default: false, null: false
      add :class_id, references(:classes, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:fee_structures, [:class_id])
    create index(:fee_structures, [:school_id])
  end
end
