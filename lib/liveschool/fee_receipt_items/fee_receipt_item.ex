defmodule Liveschool.FeeReceiptItems.FeeReceiptItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fee_receipt_items" do
    field :amount, :decimal
    field :receipt_id, :id
    field :fee_structure_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_receipt_item, attrs) do
    fee_receipt_item
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
