defmodule Liveschool.ImprestIssuesTest do
  use Liveschool.DataCase

  alias Liveschool.ImprestIssues

  describe "imprest_issues" do
    alias Liveschool.ImprestIssues.ImprestIssue

    import Liveschool.ImprestIssuesFixtures

    @invalid_attrs %{status: nil, balance: nil, amount_issued: nil, amount_returned: nil, issue_date: nil, return_date: nil, purpose: nil}

    test "list_imprest_issues/0 returns all imprest_issues" do
      imprest_issue = imprest_issue_fixture()
      assert ImprestIssues.list_imprest_issues() == [imprest_issue]
    end

    test "get_imprest_issue!/1 returns the imprest_issue with given id" do
      imprest_issue = imprest_issue_fixture()
      assert ImprestIssues.get_imprest_issue!(imprest_issue.id) == imprest_issue
    end

    test "create_imprest_issue/1 with valid data creates a imprest_issue" do
      valid_attrs = %{status: "some status", balance: "120.5", amount_issued: "120.5", amount_returned: "120.5", issue_date: ~D[2025-12-10], return_date: ~D[2025-12-10], purpose: "some purpose"}

      assert {:ok, %ImprestIssue{} = imprest_issue} = ImprestIssues.create_imprest_issue(valid_attrs)
      assert imprest_issue.status == "some status"
      assert imprest_issue.balance == Decimal.new("120.5")
      assert imprest_issue.amount_issued == Decimal.new("120.5")
      assert imprest_issue.amount_returned == Decimal.new("120.5")
      assert imprest_issue.issue_date == ~D[2025-12-10]
      assert imprest_issue.return_date == ~D[2025-12-10]
      assert imprest_issue.purpose == "some purpose"
    end

    test "create_imprest_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ImprestIssues.create_imprest_issue(@invalid_attrs)
    end

    test "update_imprest_issue/2 with valid data updates the imprest_issue" do
      imprest_issue = imprest_issue_fixture()
      update_attrs = %{status: "some updated status", balance: "456.7", amount_issued: "456.7", amount_returned: "456.7", issue_date: ~D[2025-12-11], return_date: ~D[2025-12-11], purpose: "some updated purpose"}

      assert {:ok, %ImprestIssue{} = imprest_issue} = ImprestIssues.update_imprest_issue(imprest_issue, update_attrs)
      assert imprest_issue.status == "some updated status"
      assert imprest_issue.balance == Decimal.new("456.7")
      assert imprest_issue.amount_issued == Decimal.new("456.7")
      assert imprest_issue.amount_returned == Decimal.new("456.7")
      assert imprest_issue.issue_date == ~D[2025-12-11]
      assert imprest_issue.return_date == ~D[2025-12-11]
      assert imprest_issue.purpose == "some updated purpose"
    end

    test "update_imprest_issue/2 with invalid data returns error changeset" do
      imprest_issue = imprest_issue_fixture()
      assert {:error, %Ecto.Changeset{}} = ImprestIssues.update_imprest_issue(imprest_issue, @invalid_attrs)
      assert imprest_issue == ImprestIssues.get_imprest_issue!(imprest_issue.id)
    end

    test "delete_imprest_issue/1 deletes the imprest_issue" do
      imprest_issue = imprest_issue_fixture()
      assert {:ok, %ImprestIssue{}} = ImprestIssues.delete_imprest_issue(imprest_issue)
      assert_raise Ecto.NoResultsError, fn -> ImprestIssues.get_imprest_issue!(imprest_issue.id) end
    end

    test "change_imprest_issue/1 returns a imprest_issue changeset" do
      imprest_issue = imprest_issue_fixture()
      assert %Ecto.Changeset{} = ImprestIssues.change_imprest_issue(imprest_issue)
    end
  end
end
