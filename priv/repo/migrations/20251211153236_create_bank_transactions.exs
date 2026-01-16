defmodule Liveschool.Repo.Migrations.CreateBankTransactions do
  use Ecto.Migration

  def change do
    create table(:bank_transactions) do
      add :transaction_type, :string
      add :amount, :decimal
      add :transaction_date, :date
      add :reference_number, :string
      add :description, :text
      add :related_record_id, :integer
      add :related_record_type, :string
      add :balance_after, :decimal
      add :bank_account_id, references(:bank_accounts, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bank_transactions, [:bank_account_id])
    create index(:bank_transactions, [:school_id])
  end
end
