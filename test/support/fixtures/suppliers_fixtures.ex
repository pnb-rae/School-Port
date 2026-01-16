defmodule Liveschool.SuppliersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Liveschool.Suppliers` context.
  """

  @doc """
  Generate a supplier.
  """
  def supplier_fixture(attrs \\ %{}) do
    {:ok, supplier} =
      attrs
      |> Enum.into(%{
        address: "some address",
        bank_details: %{},
        contact_person: "some contact_person",
        email: "some email",
        kra_pin: "some kra_pin",
        name: "some name",
        phone: "some phone"
      })
      |> Liveschool.Suppliers.create_supplier()

    supplier
  end
end
