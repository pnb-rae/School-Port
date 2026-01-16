defmodule Liveschool.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
      add :level, :integer
      add :capacity, :integer
      add :academic_year, :string
      add :class_teacher_id, references(:staff_members, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:classes, [:class_teacher_id])
    create index(:classes, [:school_id])
  end
end
