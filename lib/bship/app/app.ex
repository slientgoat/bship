defmodule Bship.App do
  @moduledoc """
  The App context.
  """

  import Ecto.Query, warn: false
  alias Bship.Repo

  alias Bship.App.AppInfo

  @doc """
  Returns the list of apps.

  ## Examples

      iex> list_apps()
      [%AppInfo{}, ...]

  """
  def list_apps do
    Repo.all(AppInfo)
  end

  @doc """
  Gets a single app_info.

  Raises `Ecto.NoResultsError` if the App info does not exist.

  ## Examples

      iex> get_app_info!(123)
      %AppInfo{}

      iex> get_app_info!(456)
      ** (Ecto.NoResultsError)

  """
  def get_app_info!(id), do: Repo.get!(AppInfo, id)
  def get_app_info(id), do: Repo.get(AppInfo, id)

  @doc """
  Creates a app_info.

  ## Examples

      iex> create_app_info(%{field: value})
      {:ok, %AppInfo{}}

      iex> create_app_info(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_app_info(attrs \\ %{}) do
    %AppInfo{}
    |> AppInfo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a app_info.

  ## Examples

      iex> update_app_info(app_info, %{field: new_value})
      {:ok, %AppInfo{}}

      iex> update_app_info(app_info, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_app_info(%AppInfo{} = app_info, attrs) do
    app_info
    |> AppInfo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AppInfo.

  ## Examples

      iex> delete_app_info(app_info)
      {:ok, %AppInfo{}}

      iex> delete_app_info(app_info)
      {:error, %Ecto.Changeset{}}

  """
  def delete_app_info(%AppInfo{} = app_info) do
    Repo.delete(app_info)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking app_info changes.

  ## Examples

      iex> change_app_info(app_info)
      %Ecto.Changeset{source: %AppInfo{}}

  """
  def change_app_info(%AppInfo{} = app_info) do
    AppInfo.changeset(app_info, %{})
  end
end
