defmodule Bship.App.AppInfo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bship.App.AppInfo
  @derive {Poison.Encoder, except: [:__meta__]}
  schema "apps" do
    field :eq, :integer
    field :gt, :integer
    field :lt, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%AppInfo{} = app_info, attrs) do
    app_info
    |> cast(attrs, [:name, :gt, :eq, :lt])
    |> validate_required([:name, :gt, :eq, :lt])
    |> unique_constraint(:name)
  end
end
