defmodule Liveschool.VoteHeads.VoteHead do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vote_heads" do
    field :code, :string
    field :name, :string
    field :description, :string
    field :budget_amount, :decimal
    field :spent_amount, :decimal
    field :academic_year, :string
    field :is_active, :boolean, default: false
    field :parent_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vote_head, attrs) do
    vote_head
    |> cast(attrs, [:code, :name, :description, :budget_amount, :spent_amount, :academic_year, :is_active])
    |> validate_required([:code, :name, :description, :budget_amount, :spent_amount, :academic_year, :is_active])
  end
end
