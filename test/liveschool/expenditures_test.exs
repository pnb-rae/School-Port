defmodule Liveschool.ExpendituresTest do
  use Liveschool.DataCase

  alias Liveschool.Expenditures

  describe "expenditures" do
    alias Liveschool.Expenditures.Expenditure

    import Liveschool.ExpendituresFixtures

    @invalid_attrs %{status: nil, description: nil, payment_number: nil, payee_type: nil, payee_id: nil, amount: nil, payment_method: nil, payment_date: nil}

    test "list_expenditures/0 returns all expenditures" do
      expenditure = expenditure_fixture()
      assert Expenditures.list_expenditures() == [expenditure]
    end

    test "get_expenditure!/1 returns the expenditure with given id" do
      expenditure = expenditure_fixture()
      assert Expenditures.get_expenditure!(expenditure.id) == expenditure
    end

    test "create_expenditure/1 with valid data creates a expenditure" do
      valid_attrs = %{status: "some status", description: "some description", payment_number: "some payment_number", payee_type: "some payee_type", payee_id: 42, amount: "120.5", payment_method: "some payment_method", payment_date: ~D[2025-12-10]}

      assert {:ok, %Expenditure{} = expenditure} = Expenditures.create_expenditure(valid_attrs)
      assert expenditure.status == "some status"
      assert expenditure.description == "some description"
      assert expenditure.payment_number == "some payment_number"
      assert expenditure.payee_type == "some payee_type"
      assert expenditure.payee_id == 42
      assert expenditure.amount == Decimal.new("120.5")
      assert expenditure.payment_method == "some payment_method"
      assert expenditure.payment_date == ~D[2025-12-10]
    end

    test "create_expenditure/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expenditures.create_expenditure(@invalid_attrs)
    end

    test "update_expenditure/2 with valid data updates the expenditure" do
      expenditure = expenditure_fixture()
      update_attrs = %{status: "some updated status", description: "some updated description", payment_number: "some updated payment_number", payee_type: "some updated payee_type", payee_id: 43, amount: "456.7", payment_method: "some updated payment_method", payment_date: ~D[2025-12-11]}

      assert {:ok, %Expenditure{} = expenditure} = Expenditures.update_expenditure(expenditure, update_attrs)
      assert expenditure.status == "some updated status"
      assert expenditure.description == "some updated description"
      assert expenditure.payment_number == "some updated payment_number"
      assert expenditure.payee_type == "some updated payee_type"
      assert expenditure.payee_id == 43
      assert expenditure.amount == Decimal.new("456.7")
      assert expenditure.payment_method == "some updated payment_method"
      assert expenditure.payment_date == ~D[2025-12-11]
    end

    test "update_expenditure/2 with invalid data returns error changeset" do
      expenditure = expenditure_fixture()
      assert {:error, %Ecto.Changeset{}} = Expenditures.update_expenditure(expenditure, @invalid_attrs)
      assert expenditure == Expenditures.get_expenditure!(expenditure.id)
    end

    test "delete_expenditure/1 deletes the expenditure" do
      expenditure = expenditure_fixture()
      assert {:ok, %Expenditure{}} = Expenditures.delete_expenditure(expenditure)
      assert_raise Ecto.NoResultsError, fn -> Expenditures.get_expenditure!(expenditure.id) end
    end

    test "change_expenditure/1 returns a expenditure changeset" do
      expenditure = expenditure_fixture()
      assert %Ecto.Changeset{} = Expenditures.change_expenditure(expenditure)
    end
  end
end
