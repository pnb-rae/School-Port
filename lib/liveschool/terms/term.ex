defmodule Liveschool.Terms.Term do
  use Ecto.Schema
  import Ecto.Changeset

  schema "terms" do
    field :name, :string
    field :academic_year, :string
    field :start_date, :date
    field :end_date, :date
    field :is_current, :boolean, default: false
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(term, attrs) do
    term
    |> cast(attrs, [:name, :academic_year, :start_date, :end_date, :is_current])
    |> validate_required([:name, :academic_year, :start_date, :end_date, :is_current])
  end
end
