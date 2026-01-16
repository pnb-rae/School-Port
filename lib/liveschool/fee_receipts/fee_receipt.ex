defmodule Liveschool.FeeReceipts.FeeReceipt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fee_receipts" do
    field :term, :string
    field :receipt_number, :string
    field :amount, :decimal
    field :payment_method, :string
    field :transaction_reference, :string
    field :payment_date, :date
    field :academic_year, :string
    field :notes, :string
    field :student_id, :id
    field :received_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_receipt, attrs) do
    fee_receipt
    |> cast(attrs, [:receipt_number, :amount, :payment_method, :transaction_reference, :payment_date, :academic_year, :term, :notes])
    |> validate_required([:receipt_number, :amount, :payment_method, :transaction_reference, :payment_date, :academic_year, :term, :notes])
    |> unique_constraint(:receipt_number)
  end
end
