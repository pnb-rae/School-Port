defmodule Liveschool.Repo.Migrations.CreateImprestIssues do
  use Ecto.Migration

  def change do
    create table(:imprest_issues) do
      add :amount_issued, :decimal
      add :amount_returned, :decimal
      add :balance, :decimal
      add :issue_date, :date
      add :return_date, :date
      add :purpose, :text
      add :status, :string
      add :staff_member_id, references(:staff_members, on_delete: :nothing)
      add :issued_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:imprest_issues, [:staff_member_id])
    create index(:imprest_issues, [:issued_by])
    create index(:imprest_issues, [:school_id])
  end
end
