defmodule Liveschool.BankAccountsTest do
  use Liveschool.DataCase

  alias Liveschool.BankAccounts

  describe "bank_accounts" do
    alias Liveschool.BankAccounts.BankAccount

    import Liveschool.BankAccountsFixtures

    @invalid_attrs %{name: nil, branch: nil, account_number: nil, account_name: nil, current_balance: nil, opening_balance: nil, is_active: nil}

    test "list_bank_accounts/0 returns all bank_accounts" do
      bank_account = bank_account_fixture()
      assert BankAccounts.list_bank_accounts() == [bank_account]
    end

    test "get_bank_account!/1 returns the bank_account with given id" do
      bank_account = bank_account_fixture()
      assert BankAccounts.get_bank_account!(bank_account.id) == bank_account
    end

    test "create_bank_account/1 with valid data creates a bank_account" do
      valid_attrs = %{name: "some name", branch: "some branch", account_number: "some account_number", account_name: "some account_name", current_balance: "120.5", opening_balance: "120.5", is_active: true}

      assert {:ok, %BankAccount{} = bank_account} = BankAccounts.create_bank_account(valid_attrs)
      assert bank_account.name == "some name"
      assert bank_account.branch == "some branch"
      assert bank_account.account_number == "some account_number"
      assert bank_account.account_name == "some account_name"
      assert bank_account.current_balance == Decimal.new("120.5")
      assert bank_account.opening_balance == Decimal.new("120.5")
      assert bank_account.is_active == true
    end

    test "create_bank_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BankAccounts.create_bank_account(@invalid_attrs)
    end

    test "update_bank_account/2 with valid data updates the bank_account" do
      bank_account = bank_account_fixture()
      update_attrs = %{name: "some updated name", branch: "some updated branch", account_number: "some updated account_number", account_name: "some updated account_name", current_balance: "456.7", opening_balance: "456.7", is_active: false}

      assert {:ok, %BankAccount{} = bank_account} = BankAccounts.update_bank_account(bank_account, update_attrs)
      assert bank_account.name == "some updated name"
      assert bank_account.branch == "some updated branch"
      assert bank_account.account_number == "some updated account_number"
      assert bank_account.account_name == "some updated account_name"
      assert bank_account.current_balance == Decimal.new("456.7")
      assert bank_account.opening_balance == Decimal.new("456.7")
      assert bank_account.is_active == false
    end

    test "update_bank_account/2 with invalid data returns error changeset" do
      bank_account = bank_account_fixture()
      assert {:error, %Ecto.Changeset{}} = BankAccounts.update_bank_account(bank_account, @invalid_attrs)
      assert bank_account == BankAccounts.get_bank_account!(bank_account.id)
    end

    test "delete_bank_account/1 deletes the bank_account" do
      bank_account = bank_account_fixture()
      assert {:ok, %BankAccount{}} = BankAccounts.delete_bank_account(bank_account)
      assert_raise Ecto.NoResultsError, fn -> BankAccounts.get_bank_account!(bank_account.id) end
    end

    test "change_bank_account/1 returns a bank_account changeset" do
      bank_account = bank_account_fixture()
      assert %Ecto.Changeset{} = BankAccounts.change_bank_account(bank_account)
    end
  end
end
