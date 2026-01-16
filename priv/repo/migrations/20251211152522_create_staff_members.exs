defmodule Liveschool.Repo.Migrations.CreateStaffMembers do
  use Ecto.Migration

  def change do
    create table(:staff_members) do
      add :staff_number, :string
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :email, :string
      add :date_of_birth, :date
      add :hire_date, :date
      add :position, :string
      add :salary, :decimal
      add :account_number, :string
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :department_id, references(:departments, on_delete: :nothing)
      add :bank_id, references(:bank_accounts, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:staff_members, [:staff_number])
    create index(:staff_members, [:user_id])
    create index(:staff_members, [:department_id])
    create index(:staff_members, [:bank_id])
    create index(:staff_members, [:school_id])
  end
end
