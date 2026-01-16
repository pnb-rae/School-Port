defmodule Liveschool.PocketMoneyTransactions.PocketMoneyTransaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pocket_money_transactions" do
    field :transaction_type, :string
    field :amount, :decimal
    field :balance_after, :decimal
    field :transaction_date, :date
    field :notes, :string
    field :student_id, :id
    field :handled_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(pocket_money_transaction, attrs) do
    pocket_money_transaction
    |> cast(attrs, [:transaction_type, :amount, :balance_after, :transaction_date, :notes])
    |> validate_required([:transaction_type, :amount, :balance_after, :transaction_date, :notes])
  end
end
