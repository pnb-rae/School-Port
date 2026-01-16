defmodule Liveschool.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :admission_number, :string
      add :first_name, :string
      add :middle_name, :string
      add :last_name, :string
      add :date_of_birth, :date
      add :gender, :string
      add :photo_url, :string
      add :address, :text
      add :parent_guardian_name, :string
      add :parent_guardian_phone, :string
      add :parent_guardian_email, :string
      add :admission_date, :date
      add :status, :string
      add :class_id, references(:classes, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:students, [:admission_number])
    create index(:students, [:class_id])
    create index(:students, [:school_id])
  end
end
