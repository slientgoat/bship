defmodule Bship.Guardian do
  use Guardian, otp_app: :bship
  @moduledoc """
  网页访问权限管理
  """
  alias Bship.User
  alias Bship.User.UserInfo
  def subject_for_token(%UserInfo{}=resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(nil) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    {:ok, User.get_user_info!(claims["sub"])}
  end


end
