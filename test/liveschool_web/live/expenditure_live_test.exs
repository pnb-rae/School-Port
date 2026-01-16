defmodule LiveschoolWeb.ExpenditureLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.ExpendituresFixtures

  @create_attrs %{status: "some status", description: "some description", payment_number: "some payment_number", payee_type: "some payee_type", payee_id: 42, amount: "120.5", payment_method: "some payment_method", payment_date: "2025-12-10"}
  @update_attrs %{status: "some updated status", description: "some updated description", payment_number: "some updated payment_number", payee_type: "some updated payee_type", payee_id: 43, amount: "456.7", payment_method: "some updated payment_method", payment_date: "2025-12-11"}
  @invalid_attrs %{status: nil, description: nil, payment_number: nil, payee_type: nil, payee_id: nil, amount: nil, payment_method: nil, payment_date: nil}

  defp create_expenditure(_) do
    expenditure = expenditure_fixture()
    %{expenditure: expenditure}
  end

  describe "Index" do
    setup [:create_expenditure]

    test "lists all expenditures", %{conn: conn, expenditure: expenditure} do
      {:ok, _index_live, html} = live(conn, ~p"/expenditures")

      assert html =~ "Listing Expenditures"
      assert html =~ expenditure.status
    end

    test "saves new expenditure", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/expenditures")

      assert index_live |> element("a", "New Expenditure") |> render_click() =~
               "New Expenditure"

      assert_patch(index_live, ~p"/expenditures/new")

      assert index_live
             |> form("#expenditure-form", expenditure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#expenditure-form", expenditure: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/expenditures")

      html = render(index_live)
      assert html =~ "Expenditure created successfully"
      assert html =~ "some status"
    end

    test "updates expenditure in listing", %{conn: conn, expenditure: expenditure} do
      {:ok, index_live, _html} = live(conn, ~p"/expenditures")

      assert index_live |> element("#expenditures-#{expenditure.id} a", "Edit") |> render_click() =~
               "Edit Expenditure"

      assert_patch(index_live, ~p"/expenditures/#{expenditure}/edit")

      assert index_live
             |> form("#expenditure-form", expenditure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#expenditure-form", expenditure: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/expenditures")

      html = render(index_live)
      assert html =~ "Expenditure updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes expenditure in listing", %{conn: conn, expenditure: expenditure} do
      {:ok, index_live, _html} = live(conn, ~p"/expenditures")

      assert index_live |> element("#expenditures-#{expenditure.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#expenditures-#{expenditure.id}")
    end
  end

  describe "Show" do
    setup [:create_expenditure]

    test "displays expenditure", %{conn: conn, expenditure: expenditure} do
      {:ok, _show_live, html} = live(conn, ~p"/expenditures/#{expenditure}")

      assert html =~ "Show Expenditure"
      assert html =~ expenditure.status
    end

    test "updates expenditure within modal", %{conn: conn, expenditure: expenditure} do
      {:ok, show_live, _html} = live(conn, ~p"/expenditures/#{expenditure}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Expenditure"

      assert_patch(show_live, ~p"/expenditures/#{expenditure}/show/edit")

      assert show_live
             |> form("#expenditure-form", expenditure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#expenditure-form", expenditure: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/expenditures/#{expenditure}")

      html = render(show_live)
      assert html =~ "Expenditure updated successfully"
      assert html =~ "some updated status"
    end
  end
end
