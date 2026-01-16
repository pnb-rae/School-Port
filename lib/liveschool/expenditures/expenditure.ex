defmodule Liveschool.Expenditures.Expenditure do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenditures" do
    field :status, :string
    field :description, :string
    field :payment_number, :string
    field :payee_type, :string
    field :payee_id, :integer
    field :amount, :decimal
    field :payment_method, :string
    field :payment_date, :date
    field :vote_head_id, :id
    field :approved_by, :id
    field :processed_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expenditure, attrs) do
    expenditure
    |> cast(attrs, [:payment_number, :payee_type, :payee_id, :amount, :payment_method, :description, :payment_date, :status])
    |> validate_required([:payment_number, :payee_type, :payee_id, :amount, :payment_method, :description, :payment_date, :status])
    |> unique_constraint(:payment_number)
  end
end
