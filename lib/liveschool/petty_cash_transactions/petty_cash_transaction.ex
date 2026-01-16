defmodule Liveschool.PettyCashTransactions.PettyCashTransaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "petty_cash_transactions" do
    field :description, :string
    field :transaction_type, :string
    field :amount, :decimal
    field :transaction_date, :date
    field :balance_after, :decimal
    field :handled_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(petty_cash_transaction, attrs) do
    petty_cash_transaction
    |> cast(attrs, [:transaction_type, :amount, :description, :transaction_date, :balance_after])
    |> validate_required([:transaction_type, :amount, :description, :transaction_date, :balance_after])
  end
end
