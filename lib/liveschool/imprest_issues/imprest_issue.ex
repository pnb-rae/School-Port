defmodule Liveschool.ImprestIssues.ImprestIssue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "imprest_issues" do
    field :status, :string
    field :balance, :decimal
    field :amount_issued, :decimal
    field :amount_returned, :decimal
    field :issue_date, :date
    field :return_date, :date
    field :purpose, :string
    field :staff_member_id, :id
    field :issued_by, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(imprest_issue, attrs) do
    imprest_issue
    |> cast(attrs, [:amount_issued, :amount_returned, :balance, :issue_date, :return_date, :purpose, :status])
    |> validate_required([:amount_issued, :amount_returned, :balance, :issue_date, :return_date, :purpose, :status])
  end
end
