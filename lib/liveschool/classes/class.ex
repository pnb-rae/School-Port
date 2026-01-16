defmodule Liveschool.Classes.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field :name, :string
    field :level, :integer
    field :capacity, :integer
    field :academic_year, :string
    field :class_teacher_id, :id
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name, :level, :capacity, :academic_year])
    |> validate_required([:name, :level, :capacity, :academic_year])
  end
end
