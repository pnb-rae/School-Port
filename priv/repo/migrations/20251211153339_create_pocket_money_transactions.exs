defmodule Liveschool.Repo.Migrations.CreatePocketMoneyTransactions do
  use Ecto.Migration

  def change do
    create table(:pocket_money_transactions) do
      add :transaction_type, :string
      add :amount, :decimal
      add :balance_after, :decimal
      add :transaction_date, :date
      add :notes, :text
      add :student_id, references(:students, on_delete: :nothing)
      add :handled_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:pocket_money_transactions, [:student_id])
    create index(:pocket_money_transactions, [:handled_by])
    create index(:pocket_money_transactions, [:school_id])
  end
end
