defmodule Bship.User do
  @moduledoc """
  The User context.
  """

  import Ecto.Query, warn: false
  alias Bship.Repo

  alias Bship.User.UserInfo

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%UserInfo{}, ...]

  """
  def list_users do
    Repo.all(UserInfo)
  end

  @doc """
  Gets a single user_info.

  Raises `Ecto.NoResultsError` if the User info does not exist.

  ## Examples

      iex> get_user_info!(123)
      %UserInfo{}

      iex> get_user_info!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_info!(id), do: Repo.get!(UserInfo, id)

  @doc """
  Gets a single user_info.

  Raises `Ecto.NoResultsError` if the User info does not exist.

  ## Examples

      iex> get_user_by_account("a@qq.com")
      %UserInfo{}

      iex> get_user_by_account(456)
      nil

  """
  def get_user_by_account(account), do: Repo.get_by(UserInfo,[account: account])

  @doc """
  Creates a user_info.

  ## Examples

      iex> create_user_info(%{field: value})
      {:ok, %UserInfo{}}

      iex> create_user_info(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_info(attrs \\ %{}) do
    %UserInfo{}
    |> UserInfo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_info.

  ## Examples

      iex> update_user_info(user_info, %{field: new_value})
      {:ok, %UserInfo{}}

      iex> update_user_info(user_info, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_info(%UserInfo{} = user_info, attrs) do
    user_info
    |> UserInfo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserInfo.

  ## Examples

      iex> delete_user_info(user_info)
      {:ok, %UserInfo{}}

      iex> delete_user_info(user_info)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_info(%UserInfo{} = user_info) do
    Repo.delete(user_info)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_info changes.

  ## Examples

      iex> change_user_info(user_info)
      %Ecto.Changeset{source: %UserInfo{}}

  """
  def change_user_info(%UserInfo{} = user_info) do
    UserInfo.changeset(user_info, %{})
  end

  @doc "登录验证"
  @spec check_auth(UserInfo.t,binary) :: boolean
  def check_auth(user, pwd) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(pwd, user.pwd_hash)
    end
  end

  @doc "修改密码"
  @spec chg_pwd(UserInfo.t, binary) :: {:ok, UserInfo.t} | {:error, Ecto.Changeset.t}
  def chg_pwd(user, params) do
    UserInfo.changeset_modify_password(user, params)
    |> Repo.update()
  end
end
