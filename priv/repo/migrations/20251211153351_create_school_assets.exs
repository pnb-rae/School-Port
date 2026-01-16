defmodule Liveschool.Repo.Migrations.CreateSchoolAssets do
  use Ecto.Migration

  def change do
    create table(:school_assets) do
      add :name, :string
      add :asset_number, :string
      add :category, :string
      add :purchase_date, :date
      add :purchase_price, :decimal
      add :current_value, :decimal
      add :depreciation_rate, :decimal
      add :location, :string
      add :condition, :string
      add :assigned_to, references(:staff_members, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:school_assets, [:asset_number])
    create index(:school_assets, [:assigned_to])
    create index(:school_assets, [:school_id])
  end
end
