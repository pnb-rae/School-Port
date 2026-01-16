defmodule Liveschool.BankTransactions.BankTransaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bank_transactions" do
    field :description, :string
    field :transaction_type, :string
    field :amount, :decimal
    field :transaction_date, :date
    field :reference_number, :string
    field :related_record_id, :integer
    field :related_record_type, :string
    field :balance_after, :decimal
    field :bank_account_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bank_transaction, attrs) do
    bank_transaction
    |> cast(attrs, [:transaction_type, :amount, :transaction_date, :reference_number, :description, :related_record_id, :related_record_type, :balance_after])
    |> validate_required([:transaction_type, :amount, :transaction_date, :reference_number, :description, :related_record_id, :related_record_type, :balance_after])
  end
end
