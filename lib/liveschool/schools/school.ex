defmodule Liveschool.Schools.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schools" do
    field :code, :string
    field :name, :string
    field :address, :string
    field :phone, :string
    field :email, :string
    field :logo_url, :string
    field :established_date, :date
    field :current_academic_year, :string
    field :settings, :map
    field :current_term_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :code, :address, :phone, :email, :logo_url, :established_date, :current_academic_year, :settings])
    |> validate_required([:name, :code, :address, :phone, :email, :logo_url, :established_date, :current_academic_year])
    |> unique_constraint(:code)
  end
end
