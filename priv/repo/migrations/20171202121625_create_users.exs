defmodule Bship.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :account, :string
      add :nick, :string
      add :pwd_hash, :string

      timestamps()
    end

    create unique_index(:users, [:account])
  end
end
