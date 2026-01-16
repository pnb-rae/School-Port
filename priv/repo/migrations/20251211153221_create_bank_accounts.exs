defmodule Liveschool.Repo.Migrations.CreateBankAccounts do
  use Ecto.Migration

  def change do
    create table(:bank_accounts) do
      add :name, :string
      add :branch, :string
      add :account_number, :string
      add :account_name, :string
      add :current_balance, :decimal
      add :opening_balance, :decimal
      add :is_active, :boolean, default: false, null: false
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:bank_accounts, [:school_id])
  end
end
