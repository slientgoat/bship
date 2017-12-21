defmodule Bship.User.UserInfo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bship.User.UserInfo


  schema "users" do
    field :account, :string
    field :nick, :string
    field :pwd_hash, :string
    field :pwd, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%UserInfo{} = user_info, attrs) do
    user_info
    |> cast(attrs, [:account, :nick, :pwd])
    |> validate_required([:account, :nick, :pwd])
    |> validate_length(:pwd, min: 6,max: 16)
    |> validate_format(:account, ~r/@/)
    |> unique_constraint(:account)
    |> generate_pwd_hash()
  end

  @doc """
  修改密码
  """
  def changeset_modify_password(struct, params \\ %{}) do
    chk_f = fn (:old_pwd, old_pwd) ->
      if Bship.User.check_auth(struct, old_pwd) do
        []
      else
        [old_pwd: "password is invalid!"]
      end
    end

    struct
    |> cast(params, [:old_pwd, :pwd, :pwd_hash])
    |> validate_change(:old_pwd, chk_f)
    |> validate_length(:pwd, min: 6, max: 16)
    |> validate_confirmation(:pwd, required: true)
    |> generate_pwd_hash()
  end

  defp generate_pwd_hash(cur_changeset) do
    case cur_changeset do
      %Ecto.Changeset{valid?: true, changes: %{pwd: pwd}} ->
        put_change(cur_changeset, :pwd_hash, Comeonin.Bcrypt.hashpwsalt(pwd))
      _ ->
        cur_changeset
    end
  end

  def chk_old_pwd() do

  end
end
