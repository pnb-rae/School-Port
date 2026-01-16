defmodule LiveschoolWeb.SchoolAssetLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.SchoolAssetsFixtures

  @create_attrs %{name: "some name", location: "some location", category: "some category", asset_number: "some asset_number", purchase_date: "2025-12-10", purchase_price: "120.5", current_value: "120.5", depreciation_rate: "120.5", condition: "some condition"}
  @update_attrs %{name: "some updated name", location: "some updated location", category: "some updated category", asset_number: "some updated asset_number", purchase_date: "2025-12-11", purchase_price: "456.7", current_value: "456.7", depreciation_rate: "456.7", condition: "some updated condition"}
  @invalid_attrs %{name: nil, location: nil, category: nil, asset_number: nil, purchase_date: nil, purchase_price: nil, current_value: nil, depreciation_rate: nil, condition: nil}

  defp create_school_asset(_) do
    school_asset = school_asset_fixture()
    %{school_asset: school_asset}
  end

  describe "Index" do
    setup [:create_school_asset]

    test "lists all school_assets", %{conn: conn, school_asset: school_asset} do
      {:ok, _index_live, html} = live(conn, ~p"/school_assets")

      assert html =~ "Listing School assets"
      assert html =~ school_asset.name
    end

    test "saves new school_asset", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/school_assets")

      assert index_live |> element("a", "New School asset") |> render_click() =~
               "New School asset"

      assert_patch(index_live, ~p"/school_assets/new")

      assert index_live
             |> form("#school_asset-form", school_asset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school_asset-form", school_asset: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/school_assets")

      html = render(index_live)
      assert html =~ "School asset created successfully"
      assert html =~ "some name"
    end

    test "updates school_asset in listing", %{conn: conn, school_asset: school_asset} do
      {:ok, index_live, _html} = live(conn, ~p"/school_assets")

      assert index_live |> element("#school_assets-#{school_asset.id} a", "Edit") |> render_click() =~
               "Edit School asset"

      assert_patch(index_live, ~p"/school_assets/#{school_asset}/edit")

      assert index_live
             |> form("#school_asset-form", school_asset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#school_asset-form", school_asset: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/school_assets")

      html = render(index_live)
      assert html =~ "School asset updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes school_asset in listing", %{conn: conn, school_asset: school_asset} do
      {:ok, index_live, _html} = live(conn, ~p"/school_assets")

      assert index_live |> element("#school_assets-#{school_asset.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#school_assets-#{school_asset.id}")
    end
  end

  describe "Show" do
    setup [:create_school_asset]

    test "displays school_asset", %{conn: conn, school_asset: school_asset} do
      {:ok, _show_live, html} = live(conn, ~p"/school_assets/#{school_asset}")

      assert html =~ "Show School asset"
      assert html =~ school_asset.name
    end

    test "updates school_asset within modal", %{conn: conn, school_asset: school_asset} do
      {:ok, show_live, _html} = live(conn, ~p"/school_assets/#{school_asset}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit School asset"

      assert_patch(show_live, ~p"/school_assets/#{school_asset}/show/edit")

      assert show_live
             |> form("#school_asset-form", school_asset: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#school_asset-form", school_asset: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/school_assets/#{school_asset}")

      html = render(show_live)
      assert html =~ "School asset updated successfully"
      assert html =~ "some updated name"
    end
  end
end
