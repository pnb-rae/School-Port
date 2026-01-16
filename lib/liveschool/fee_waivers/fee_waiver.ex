defmodule Liveschool.FeeWaivers.FeeWaiver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fee_waivers" do
    field :reason, :string
    field :term, :string
    field :waiver_type, :string
    field :amount_or_percentage, :decimal
    field :academic_year, :string
    field :student_id, :id
    field :fee_structure_id, :id
    field :approved_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_waiver, attrs) do
    fee_waiver
    |> cast(attrs, [:waiver_type, :amount_or_percentage, :reason, :academic_year, :term])
    |> validate_required([:waiver_type, :amount_or_percentage, :reason, :academic_year, :term])
  end
end
