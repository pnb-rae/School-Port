defmodule Liveschool.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :contact_person, :string
      add :phone, :string
      add :email, :string
      add :address, :text
      add :kra_pin, :string
      add :bank_details, :map
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:suppliers, [:school_id])
  end
end
