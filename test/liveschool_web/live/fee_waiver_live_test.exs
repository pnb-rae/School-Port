defmodule LiveschoolWeb.FeeWaiverLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.FeeWaiversFixtures

  @create_attrs %{reason: "some reason", term: "some term", waiver_type: "some waiver_type", amount_or_percentage: "120.5", academic_year: "some academic_year"}
  @update_attrs %{reason: "some updated reason", term: "some updated term", waiver_type: "some updated waiver_type", amount_or_percentage: "456.7", academic_year: "some updated academic_year"}
  @invalid_attrs %{reason: nil, term: nil, waiver_type: nil, amount_or_percentage: nil, academic_year: nil}

  defp create_fee_waiver(_) do
    fee_waiver = fee_waiver_fixture()
    %{fee_waiver: fee_waiver}
  end

  describe "Index" do
    setup [:create_fee_waiver]

    test "lists all fee_waivers", %{conn: conn, fee_waiver: fee_waiver} do
      {:ok, _index_live, html} = live(conn, ~p"/fee_waivers")

      assert html =~ "Listing Fee waivers"
      assert html =~ fee_waiver.reason
    end

    test "saves new fee_waiver", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_waivers")

      assert index_live |> element("a", "New Fee waiver") |> render_click() =~
               "New Fee waiver"

      assert_patch(index_live, ~p"/fee_waivers/new")

      assert index_live
             |> form("#fee_waiver-form", fee_waiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_waiver-form", fee_waiver: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_waivers")

      html = render(index_live)
      assert html =~ "Fee waiver created successfully"
      assert html =~ "some reason"
    end

    test "updates fee_waiver in listing", %{conn: conn, fee_waiver: fee_waiver} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_waivers")

      assert index_live |> element("#fee_waivers-#{fee_waiver.id} a", "Edit") |> render_click() =~
               "Edit Fee waiver"

      assert_patch(index_live, ~p"/fee_waivers/#{fee_waiver}/edit")

      assert index_live
             |> form("#fee_waiver-form", fee_waiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#fee_waiver-form", fee_waiver: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fee_waivers")

      html = render(index_live)
      assert html =~ "Fee waiver updated successfully"
      assert html =~ "some updated reason"
    end

    test "deletes fee_waiver in listing", %{conn: conn, fee_waiver: fee_waiver} do
      {:ok, index_live, _html} = live(conn, ~p"/fee_waivers")

      assert index_live |> element("#fee_waivers-#{fee_waiver.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fee_waivers-#{fee_waiver.id}")
    end
  end

  describe "Show" do
    setup [:create_fee_waiver]

    test "displays fee_waiver", %{conn: conn, fee_waiver: fee_waiver} do
      {:ok, _show_live, html} = live(conn, ~p"/fee_waivers/#{fee_waiver}")

      assert html =~ "Show Fee waiver"
      assert html =~ fee_waiver.reason
    end

    test "updates fee_waiver within modal", %{conn: conn, fee_waiver: fee_waiver} do
      {:ok, show_live, _html} = live(conn, ~p"/fee_waivers/#{fee_waiver}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Fee waiver"

      assert_patch(show_live, ~p"/fee_waivers/#{fee_waiver}/show/edit")

      assert show_live
             |> form("#fee_waiver-form", fee_waiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#fee_waiver-form", fee_waiver: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fee_waivers/#{fee_waiver}")

      html = render(show_live)
      assert html =~ "Fee waiver updated successfully"
      assert html =~ "some updated reason"
    end
  end
end
