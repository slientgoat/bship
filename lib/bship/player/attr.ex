defmodule Bship.Player.Attr do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bship.Player.Attr


  schema "attrs" do
    field :score, :integer
    field :uid_id, :id
    field :appid_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Attr{} = attr, attrs) do
    attr
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
