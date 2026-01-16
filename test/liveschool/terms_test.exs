defmodule Liveschool.TermsTest do
  use Liveschool.DataCase

  alias Liveschool.Terms

  describe "terms" do
    alias Liveschool.Terms.Term

    import Liveschool.TermsFixtures

    @invalid_attrs %{name: nil, academic_year: nil, start_date: nil, end_date: nil, is_current: nil}

    test "list_terms/0 returns all terms" do
      term = term_fixture()
      assert Terms.list_terms() == [term]
    end

    test "get_term!/1 returns the term with given id" do
      term = term_fixture()
      assert Terms.get_term!(term.id) == term
    end

    test "create_term/1 with valid data creates a term" do
      valid_attrs = %{name: "some name", academic_year: "some academic_year", start_date: ~D[2025-12-10], end_date: ~D[2025-12-10], is_current: true}

      assert {:ok, %Term{} = term} = Terms.create_term(valid_attrs)
      assert term.name == "some name"
      assert term.academic_year == "some academic_year"
      assert term.start_date == ~D[2025-12-10]
      assert term.end_date == ~D[2025-12-10]
      assert term.is_current == true
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Terms.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = term_fixture()
      update_attrs = %{name: "some updated name", academic_year: "some updated academic_year", start_date: ~D[2025-12-11], end_date: ~D[2025-12-11], is_current: false}

      assert {:ok, %Term{} = term} = Terms.update_term(term, update_attrs)
      assert term.name == "some updated name"
      assert term.academic_year == "some updated academic_year"
      assert term.start_date == ~D[2025-12-11]
      assert term.end_date == ~D[2025-12-11]
      assert term.is_current == false
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = term_fixture()
      assert {:error, %Ecto.Changeset{}} = Terms.update_term(term, @invalid_attrs)
      assert term == Terms.get_term!(term.id)
    end

    test "delete_term/1 deletes the term" do
      term = term_fixture()
      assert {:ok, %Term{}} = Terms.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> Terms.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = term_fixture()
      assert %Ecto.Changeset{} = Terms.change_term(term)
    end
  end
end
