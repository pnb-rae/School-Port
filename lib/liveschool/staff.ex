defmodule Liveschool.Staff do
  @moduledoc """
  The Staff context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.Staff.StaffMember

  @doc """
  Returns the list of staff_members.

  ## Examples

      iex> list_staff_members()
      [%StaffMember{}, ...]

  """
  def list_staff_members do
    Repo.all(StaffMember)
  end

  @doc """
  Gets a single staff_member.

  Raises `Ecto.NoResultsError` if the Staff member does not exist.

  ## Examples

      iex> get_staff_member!(123)
      %StaffMember{}

      iex> get_staff_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_staff_member!(id), do: Repo.get!(StaffMember, id)

  @doc """
  Creates a staff_member.

  ## Examples

      iex> create_staff_member(%{field: value})
      {:ok, %StaffMember{}}

      iex> create_staff_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_staff_member(attrs \\ %{}) do
    %StaffMember{}
    |> StaffMember.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a staff_member.

  ## Examples

      iex> update_staff_member(staff_member, %{field: new_value})
      {:ok, %StaffMember{}}

      iex> update_staff_member(staff_member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_staff_member(%StaffMember{} = staff_member, attrs) do
    staff_member
    |> StaffMember.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a staff_member.

  ## Examples

      iex> delete_staff_member(staff_member)
      {:ok, %StaffMember{}}

      iex> delete_staff_member(staff_member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_staff_member(%StaffMember{} = staff_member) do
    Repo.delete(staff_member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking staff_member changes.

  ## Examples

      iex> change_staff_member(staff_member)
      %Ecto.Changeset{data: %StaffMember{}}

  """
  def change_staff_member(%StaffMember{} = staff_member, attrs \\ %{}) do
    StaffMember.changeset(staff_member, attrs)
  end
end
