defmodule Liveschool.Repo.Migrations.CreateDepartments do
  use Ecto.Migration

  def change do
    create table(:departments) do
      add :name, :string
      add :code, :string
      add :budget_allocation, :decimal
      add :head_of_department_id, references(:staff_members, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:departments, [:head_of_department_id])
    create index(:departments, [:school_id])
  end
end
