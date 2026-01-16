defmodule Liveschool.SchoolAssets.SchoolAsset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "school_assets" do
    field :name, :string
    field :location, :string
    field :category, :string
    field :asset_number, :string
    field :purchase_date, :date
    field :purchase_price, :decimal
    field :current_value, :decimal
    field :depreciation_rate, :decimal
    field :condition, :string
    field :assigned_to, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(school_asset, attrs) do
    school_asset
    |> cast(attrs, [:name, :asset_number, :category, :purchase_date, :purchase_price, :current_value, :depreciation_rate, :location, :condition])
    |> validate_required([:name, :asset_number, :category, :purchase_date, :purchase_price, :current_value, :depreciation_rate, :location, :condition])
    |> unique_constraint(:asset_number)
  end
end
