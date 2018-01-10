defmodule Bship.Repo.Migrations.AlterAppsTable do
  use Ecto.Migration

  def up do
    alter table("apps") do
      add :icon, :string
    end
  end

  def down do
    alter table("apps") do
      remove :icon
    end
  end
end
