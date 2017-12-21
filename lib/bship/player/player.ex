defmodule Bship.Player do
  @moduledoc """
  The Player context.
  """

  import Ecto.Query, warn: false
  alias Bship.Repo

  alias Bship.Player.Attr

  @doc """
  Returns the list of attrs.

  ## Examples

      iex> list_attrs()
      [%Attr{}, ...]

  """
  def list_attrs do
    Repo.all(Attr)
  end

  @doc """
  Gets a single attr.

  Raises `Ecto.NoResultsError` if the Attr does not exist.

  ## Examples

      iex> get_attr!(123)
      %Attr{}

      iex> get_attr!(456)
      ** (Ecto.NoResultsError)

  """
  def get_attr!(id), do: Repo.get!(Attr, id)

  @doc """
  Creates a attr.

  ## Examples

      iex> create_attr(%{field: value})
      {:ok, %Attr{}}

      iex> create_attr(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_attr(attrs \\ %{}) do
    %Attr{}
    |> Attr.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a attr.

  ## Examples

      iex> update_attr(attr, %{field: new_value})
      {:ok, %Attr{}}

      iex> update_attr(attr, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_attr(%Attr{} = attr, attrs) do
    attr
    |> Attr.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Attr.

  ## Examples

      iex> delete_attr(attr)
      {:ok, %Attr{}}

      iex> delete_attr(attr)
      {:error, %Ecto.Changeset{}}

  """
  def delete_attr(%Attr{} = attr) do
    Repo.delete(attr)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attr changes.

  ## Examples

      iex> change_attr(attr)
      %Ecto.Changeset{source: %Attr{}}

  """
  def change_attr(%Attr{} = attr) do
    Attr.changeset(attr, %{})
  end
end
