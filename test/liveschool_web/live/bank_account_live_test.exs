defmodule LiveschoolWeb.BankAccountLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.BankAccountsFixtures

  @create_attrs %{name: "some name", branch: "some branch", account_number: "some account_number", account_name: "some account_name", current_balance: "120.5", opening_balance: "120.5", is_active: true}
  @update_attrs %{name: "some updated name", branch: "some updated branch", account_number: "some updated account_number", account_name: "some updated account_name", current_balance: "456.7", opening_balance: "456.7", is_active: false}
  @invalid_attrs %{name: nil, branch: nil, account_number: nil, account_name: nil, current_balance: nil, opening_balance: nil, is_active: false}

  defp create_bank_account(_) do
    bank_account = bank_account_fixture()
    %{bank_account: bank_account}
  end

  describe "Index" do
    setup [:create_bank_account]

    test "lists all bank_accounts", %{conn: conn, bank_account: bank_account} do
      {:ok, _index_live, html} = live(conn, ~p"/bank_accounts")

      assert html =~ "Listing Bank accounts"
      assert html =~ bank_account.name
    end

    test "saves new bank_account", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_accounts")

      assert index_live |> element("a", "New Bank account") |> render_click() =~
               "New Bank account"

      assert_patch(index_live, ~p"/bank_accounts/new")

      assert index_live
             |> form("#bank_account-form", bank_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank_account-form", bank_account: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bank_accounts")

      html = render(index_live)
      assert html =~ "Bank account created successfully"
      assert html =~ "some name"
    end

    test "updates bank_account in listing", %{conn: conn, bank_account: bank_account} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_accounts")

      assert index_live |> element("#bank_accounts-#{bank_account.id} a", "Edit") |> render_click() =~
               "Edit Bank account"

      assert_patch(index_live, ~p"/bank_accounts/#{bank_account}/edit")

      assert index_live
             |> form("#bank_account-form", bank_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bank_account-form", bank_account: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/bank_accounts")

      html = render(index_live)
      assert html =~ "Bank account updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes bank_account in listing", %{conn: conn, bank_account: bank_account} do
      {:ok, index_live, _html} = live(conn, ~p"/bank_accounts")

      assert index_live |> element("#bank_accounts-#{bank_account.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#bank_accounts-#{bank_account.id}")
    end
  end

  describe "Show" do
    setup [:create_bank_account]

    test "displays bank_account", %{conn: conn, bank_account: bank_account} do
      {:ok, _show_live, html} = live(conn, ~p"/bank_accounts/#{bank_account}")

      assert html =~ "Show Bank account"
      assert html =~ bank_account.name
    end

    test "updates bank_account within modal", %{conn: conn, bank_account: bank_account} do
      {:ok, show_live, _html} = live(conn, ~p"/bank_accounts/#{bank_account}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bank account"

      assert_patch(show_live, ~p"/bank_accounts/#{bank_account}/show/edit")

      assert show_live
             |> form("#bank_account-form", bank_account: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bank_account-form", bank_account: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/bank_accounts/#{bank_account}")

      html = render(show_live)
      assert html =~ "Bank account updated successfully"
      assert html =~ "some updated name"
    end
  end
end
