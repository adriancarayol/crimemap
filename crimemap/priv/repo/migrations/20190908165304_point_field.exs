defmodule Crimemap.Repo.Migrations.PointField do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
  end

  def down do
    execute "DROP EXTENSION IF EXISTS postgis"
  end

  def change do
    alter table(:crimes) do
      add :point, :geometry
    end
  end
end
