defmodule Liveschool.Repo.Migrations.CreatePettyCashTransactions do
  use Ecto.Migration

  def change do
    create table(:petty_cash_transactions) do
      add :transaction_type, :string
      add :amount, :decimal
      add :description, :text
      add :transaction_date, :date
      add :balance_after, :decimal
      add :handled_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:petty_cash_transactions, [:handled_by])
    create index(:petty_cash_transactions, [:school_id])
  end
end
