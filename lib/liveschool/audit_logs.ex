defmodule Liveschool.AuditLogs do
  @moduledoc """
  The AuditLogs context.
  """

  import Ecto.Query, warn: false
  alias Liveschool.Repo

  alias Liveschool.AuditLogs.AuditLog

  @doc """
  Returns the list of audit_logs.

  ## Examples

      iex> list_audit_logs()
      [%AuditLog{}, ...]

  """
  def list_audit_logs do
    Repo.all(AuditLog)
  end

  @doc """
  Gets a single audit_log.

  Raises `Ecto.NoResultsError` if the Audit log does not exist.

  ## Examples

      iex> get_audit_log!(123)
      %AuditLog{}

      iex> get_audit_log!(456)
      ** (Ecto.NoResultsError)

  """
  def get_audit_log!(id), do: Repo.get!(AuditLog, id)

  @doc """
  Creates a audit_log.

  ## Examples

      iex> create_audit_log(%{field: value})
      {:ok, %AuditLog{}}

      iex> create_audit_log(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_audit_log(attrs \\ %{}) do
    %AuditLog{}
    |> AuditLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a audit_log.

  ## Examples

      iex> update_audit_log(audit_log, %{field: new_value})
      {:ok, %AuditLog{}}

      iex> update_audit_log(audit_log, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_audit_log(%AuditLog{} = audit_log, attrs) do
    audit_log
    |> AuditLog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a audit_log.

  ## Examples

      iex> delete_audit_log(audit_log)
      {:ok, %AuditLog{}}

      iex> delete_audit_log(audit_log)
      {:error, %Ecto.Changeset{}}

  """
  def delete_audit_log(%AuditLog{} = audit_log) do
    Repo.delete(audit_log)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking audit_log changes.

  ## Examples

      iex> change_audit_log(audit_log)
      %Ecto.Changeset{data: %AuditLog{}}

  """
  def change_audit_log(%AuditLog{} = audit_log, attrs \\ %{}) do
    AuditLog.changeset(audit_log, attrs)
  end
end
