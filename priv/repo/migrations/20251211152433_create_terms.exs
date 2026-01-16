defmodule Liveschool.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:terms) do
      add :name, :string
      add :academic_year, :string
      add :start_date, :date
      add :end_date, :date
      add :is_current, :boolean, default: false, null: false
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:terms, [:school_id])
  end
end
