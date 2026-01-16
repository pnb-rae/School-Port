defmodule Liveschool.Suppliers.Supplier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suppliers" do
    field :name, :string
    field :address, :string
    field :contact_person, :string
    field :phone, :string
    field :email, :string
    field :kra_pin, :string
    field :bank_details, :map
    field :school_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :contact_person, :phone, :email, :address, :kra_pin, :bank_details])
    |> validate_required([:name, :contact_person, :phone, :email, :address, :kra_pin])
  end
end
