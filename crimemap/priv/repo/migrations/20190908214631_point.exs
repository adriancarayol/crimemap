defmodule Crimemap.Repo.Migrations.Point do
  use Ecto.Migration

  def change do
    alter table(:crimes) do
      add :point, :geometry
    end
  end
end
