defmodule Liveschool.Repo.Migrations.CreateFeeReceipts do
  use Ecto.Migration

  def change do
    create table(:fee_receipts) do
      add :receipt_number, :string
      add :amount, :decimal
      add :payment_method, :string
      add :transaction_reference, :string
      add :payment_date, :date
      add :academic_year, :string
      add :term, :string
      add :notes, :text
      add :student_id, references(:students, on_delete: :nothing)
      add :received_by, references(:users, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:fee_receipts, [:receipt_number])
    create index(:fee_receipts, [:student_id])
    create index(:fee_receipts, [:received_by])
    create index(:fee_receipts, [:school_id])
  end
end
