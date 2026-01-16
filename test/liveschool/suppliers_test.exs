defmodule Liveschool.SuppliersTest do
  use Liveschool.DataCase

  alias Liveschool.Suppliers

  describe "suppliers" do
    alias Liveschool.Suppliers.Supplier

    import Liveschool.SuppliersFixtures

    @invalid_attrs %{name: nil, address: nil, contact_person: nil, phone: nil, email: nil, kra_pin: nil, bank_details: nil}

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Suppliers.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Suppliers.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      valid_attrs = %{name: "some name", address: "some address", contact_person: "some contact_person", phone: "some phone", email: "some email", kra_pin: "some kra_pin", bank_details: %{}}

      assert {:ok, %Supplier{} = supplier} = Suppliers.create_supplier(valid_attrs)
      assert supplier.name == "some name"
      assert supplier.address == "some address"
      assert supplier.contact_person == "some contact_person"
      assert supplier.phone == "some phone"
      assert supplier.email == "some email"
      assert supplier.kra_pin == "some kra_pin"
      assert supplier.bank_details == %{}
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suppliers.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", contact_person: "some updated contact_person", phone: "some updated phone", email: "some updated email", kra_pin: "some updated kra_pin", bank_details: %{}}

      assert {:ok, %Supplier{} = supplier} = Suppliers.update_supplier(supplier, update_attrs)
      assert supplier.name == "some updated name"
      assert supplier.address == "some updated address"
      assert supplier.contact_person == "some updated contact_person"
      assert supplier.phone == "some updated phone"
      assert supplier.email == "some updated email"
      assert supplier.kra_pin == "some updated kra_pin"
      assert supplier.bank_details == %{}
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Suppliers.update_supplier(supplier, @invalid_attrs)
      assert supplier == Suppliers.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Suppliers.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Suppliers.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Suppliers.change_supplier(supplier)
    end
  end
end
