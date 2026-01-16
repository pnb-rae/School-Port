defmodule Liveschool.Departments.Department do
  use Ecto.Schema
  import Ecto.Changeset

  schema "departments" do
    field :code, :string
    field :name, :string
    field :budget_allocation, :decimal
    field :head_of_department_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, [:name, :code, :budget_allocation])
    |> validate_required([:name, :code, :budget_allocation])
  end
end
