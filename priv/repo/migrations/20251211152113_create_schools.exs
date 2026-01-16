defmodule Liveschool.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :name, :string
      add :code, :string
      add :address, :text
      add :phone, :string
      add :email, :string
      add :logo_url, :string
      add :established_date, :date
      add :current_academic_year, :string
      add :settings, :map
      add :current_term_id, references(:terms, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:schools, [:code])
    create index(:schools, [:current_term_id])
  end
end
