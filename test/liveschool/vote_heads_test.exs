defmodule Liveschool.VoteHeadsTest do
  use Liveschool.DataCase

  alias Liveschool.VoteHeads

  describe "vote_heads" do
    alias Liveschool.VoteHeads.VoteHead

    import Liveschool.VoteHeadsFixtures

    @invalid_attrs %{code: nil, name: nil, description: nil, budget_amount: nil, spent_amount: nil, academic_year: nil, is_active: nil}

    test "list_vote_heads/0 returns all vote_heads" do
      vote_head = vote_head_fixture()
      assert VoteHeads.list_vote_heads() == [vote_head]
    end

    test "get_vote_head!/1 returns the vote_head with given id" do
      vote_head = vote_head_fixture()
      assert VoteHeads.get_vote_head!(vote_head.id) == vote_head
    end

    test "create_vote_head/1 with valid data creates a vote_head" do
      valid_attrs = %{code: "some code", name: "some name", description: "some description", budget_amount: "120.5", spent_amount: "120.5", academic_year: "some academic_year", is_active: true}

      assert {:ok, %VoteHead{} = vote_head} = VoteHeads.create_vote_head(valid_attrs)
      assert vote_head.code == "some code"
      assert vote_head.name == "some name"
      assert vote_head.description == "some description"
      assert vote_head.budget_amount == Decimal.new("120.5")
      assert vote_head.spent_amount == Decimal.new("120.5")
      assert vote_head.academic_year == "some academic_year"
      assert vote_head.is_active == true
    end

    test "create_vote_head/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = VoteHeads.create_vote_head(@invalid_attrs)
    end

    test "update_vote_head/2 with valid data updates the vote_head" do
      vote_head = vote_head_fixture()
      update_attrs = %{code: "some updated code", name: "some updated name", description: "some updated description", budget_amount: "456.7", spent_amount: "456.7", academic_year: "some updated academic_year", is_active: false}

      assert {:ok, %VoteHead{} = vote_head} = VoteHeads.update_vote_head(vote_head, update_attrs)
      assert vote_head.code == "some updated code"
      assert vote_head.name == "some updated name"
      assert vote_head.description == "some updated description"
      assert vote_head.budget_amount == Decimal.new("456.7")
      assert vote_head.spent_amount == Decimal.new("456.7")
      assert vote_head.academic_year == "some updated academic_year"
      assert vote_head.is_active == false
    end

    test "update_vote_head/2 with invalid data returns error changeset" do
      vote_head = vote_head_fixture()
      assert {:error, %Ecto.Changeset{}} = VoteHeads.update_vote_head(vote_head, @invalid_attrs)
      assert vote_head == VoteHeads.get_vote_head!(vote_head.id)
    end

    test "delete_vote_head/1 deletes the vote_head" do
      vote_head = vote_head_fixture()
      assert {:ok, %VoteHead{}} = VoteHeads.delete_vote_head(vote_head)
      assert_raise Ecto.NoResultsError, fn -> VoteHeads.get_vote_head!(vote_head.id) end
    end

    test "change_vote_head/1 returns a vote_head changeset" do
      vote_head = vote_head_fixture()
      assert %Ecto.Changeset{} = VoteHeads.change_vote_head(vote_head)
    end
  end
end
