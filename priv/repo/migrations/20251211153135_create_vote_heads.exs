defmodule Liveschool.Repo.Migrations.CreateVoteHeads do
  use Ecto.Migration

  def change do
    create table(:vote_heads) do
      add :code, :string
      add :name, :string
      add :description, :text
      add :budget_amount, :decimal
      add :spent_amount, :decimal
      add :academic_year, :string
      add :is_active, :boolean, default: false, null: false
      add :parent_id, references(:vote_heads, on_delete: :nothing)
      add :school_id, references(:schools, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:vote_heads, [:parent_id])
    create index(:vote_heads, [:school_id])
  end
end
