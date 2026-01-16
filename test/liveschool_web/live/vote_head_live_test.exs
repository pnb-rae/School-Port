defmodule LiveschoolWeb.VoteHeadLiveTest do
  use LiveschoolWeb.ConnCase

  import Phoenix.LiveViewTest
  import Liveschool.VoteHeadsFixtures

  @create_attrs %{code: "some code", name: "some name", description: "some description", budget_amount: "120.5", spent_amount: "120.5", academic_year: "some academic_year", is_active: true}
  @update_attrs %{code: "some updated code", name: "some updated name", description: "some updated description", budget_amount: "456.7", spent_amount: "456.7", academic_year: "some updated academic_year", is_active: false}
  @invalid_attrs %{code: nil, name: nil, description: nil, budget_amount: nil, spent_amount: nil, academic_year: nil, is_active: false}

  defp create_vote_head(_) do
    vote_head = vote_head_fixture()
    %{vote_head: vote_head}
  end

  describe "Index" do
    setup [:create_vote_head]

    test "lists all vote_heads", %{conn: conn, vote_head: vote_head} do
      {:ok, _index_live, html} = live(conn, ~p"/vote_heads")

      assert html =~ "Listing Vote heads"
      assert html =~ vote_head.code
    end

    test "saves new vote_head", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/vote_heads")

      assert index_live |> element("a", "New Vote head") |> render_click() =~
               "New Vote head"

      assert_patch(index_live, ~p"/vote_heads/new")

      assert index_live
             |> form("#vote_head-form", vote_head: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vote_head-form", vote_head: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vote_heads")

      html = render(index_live)
      assert html =~ "Vote head created successfully"
      assert html =~ "some code"
    end

    test "updates vote_head in listing", %{conn: conn, vote_head: vote_head} do
      {:ok, index_live, _html} = live(conn, ~p"/vote_heads")

      assert index_live |> element("#vote_heads-#{vote_head.id} a", "Edit") |> render_click() =~
               "Edit Vote head"

      assert_patch(index_live, ~p"/vote_heads/#{vote_head}/edit")

      assert index_live
             |> form("#vote_head-form", vote_head: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#vote_head-form", vote_head: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/vote_heads")

      html = render(index_live)
      assert html =~ "Vote head updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes vote_head in listing", %{conn: conn, vote_head: vote_head} do
      {:ok, index_live, _html} = live(conn, ~p"/vote_heads")

      assert index_live |> element("#vote_heads-#{vote_head.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#vote_heads-#{vote_head.id}")
    end
  end

  describe "Show" do
    setup [:create_vote_head]

    test "displays vote_head", %{conn: conn, vote_head: vote_head} do
      {:ok, _show_live, html} = live(conn, ~p"/vote_heads/#{vote_head}")

      assert html =~ "Show Vote head"
      assert html =~ vote_head.code
    end

    test "updates vote_head within modal", %{conn: conn, vote_head: vote_head} do
      {:ok, show_live, _html} = live(conn, ~p"/vote_heads/#{vote_head}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Vote head"

      assert_patch(show_live, ~p"/vote_heads/#{vote_head}/show/edit")

      assert show_live
             |> form("#vote_head-form", vote_head: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#vote_head-form", vote_head: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/vote_heads/#{vote_head}")

      html = render(show_live)
      assert html =~ "Vote head updated successfully"
      assert html =~ "some updated code"
    end
  end
end
