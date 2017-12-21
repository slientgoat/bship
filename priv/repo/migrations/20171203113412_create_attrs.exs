defmodule Bship.Repo.Migrations.CreateAttrs do
  use Ecto.Migration

  def change do
    create table(:attrs) do
      add :score, :integer
      add :uid_id, references(:users, on_delete: :nothing)
      add :appid_id, references(:apps, on_delete: :nothing)

      timestamps()
    end

#    create index(:attrs, [:uid])
#    create index(:attrs, [:appid])
  end
end
