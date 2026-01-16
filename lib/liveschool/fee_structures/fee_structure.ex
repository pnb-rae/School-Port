defmodule Liveschool.FeeStructures.FeeStructure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fee_structures" do
    field :name, :string
    field :term, :string
    field :amount, :decimal
    field :fee_type, :string
    field :payment_frequency, :string
    field :academic_year, :string
    field :is_mandatory, :boolean, default: false
    field :class_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_structure, attrs) do
    fee_structure
    |> cast(attrs, [:name, :amount, :fee_type, :payment_frequency, :academic_year, :term, :is_mandatory])
    |> validate_required([:name, :amount, :fee_type, :payment_frequency, :academic_year, :term, :is_mandatory])
  end
end
