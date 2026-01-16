defmodule Liveschool.Repo.Migrations.CreateFeeReceiptItems do
  use Ecto.Migration

  def change do
    create table(:fee_receipt_items) do
      add :amount, :decimal
      add :receipt_id, references(:fee_receipts, on_delete: :nothing)
      add :fee_structure_id, references(:fee_structures, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:fee_receipt_items, [:receipt_id])
    create index(:fee_receipt_items, [:fee_structure_id])
  end
end
