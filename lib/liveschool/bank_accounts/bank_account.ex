defmodule Liveschool.BankAccounts.BankAccount do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bank_accounts" do
    field :name, :string
    field :branch, :string
    field :account_number, :string
    field :account_name, :string
    field :current_balance, :decimal
    field :opening_balance, :decimal
    field :is_active, :boolean, default: false
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bank_account, attrs) do
    bank_account
    |> cast(attrs, [:name, :branch, :account_number, :account_name, :current_balance, :opening_balance, :is_active])
    |> validate_required([:name, :branch, :account_number, :account_name, :current_balance, :opening_balance, :is_active])
  end
end
