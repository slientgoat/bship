defmodule Bship.Repo.Migrations.CreateApps do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :name, :string
      add :gt, :integer
      add :eq, :integer
      add :lt, :integer

      timestamps()
    end

    create unique_index(:apps, [:name])
  end
end
