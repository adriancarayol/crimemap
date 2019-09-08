defmodule Crimemap.Repo.Migrations.LongAndLatFloat do
  use Ecto.Migration

  def change do
    alter table(:crimes) do
      modify :latitude, :decimal, precision: 15
      modify :longitude, :decimal, precision: 15
    end
  end
end
