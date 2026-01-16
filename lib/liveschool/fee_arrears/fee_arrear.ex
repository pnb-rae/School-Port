defmodule Liveschool.FeeArrears.FeeArrear do
  use Ecto.Schema
  import Ecto.Changeset

  schema "fee_arrears" do
    field :status, :string
    field :term, :string
    field :amount, :decimal
    field :academic_year, :string
    field :notes, :string
    field :student_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(fee_arrear, attrs) do
    fee_arrear
    |> cast(attrs, [:amount, :academic_year, :term, :notes, :status])
    |> validate_required([:amount, :academic_year, :term, :notes, :status])
  end
end
