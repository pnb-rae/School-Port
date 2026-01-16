defmodule Liveschool.Repo.Migrations.CreateExpenditures do
  use Ecto.Migration

  def change do
    create table(:expenditures) do
      add :payment_number, :string
      add :payee_type, :string
      add :payee_id, :integer
      add :amount, :decimal
      add :payment_method, :string
      add :description, :text
      add :payment_date, :date
      add :status, :string
      add :vote_head_id, references(:vote_heads, on_delete: :nothing)
      add :approved_by, references(:users, on_delete: :nothing)
      add :processed_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:expenditures, [:payment_number])
    create index(:expenditures, [:vote_head_id])
    create index(:expenditures, [:approved_by])
    create index(:expenditures, [:processed_by])
    create index(:expenditures, [:school_id])
  end
end
