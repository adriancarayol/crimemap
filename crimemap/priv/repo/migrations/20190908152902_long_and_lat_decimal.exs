defmodule Crimemap.Repo.Migrations.LongAndLatDecimal do
  use Ecto.Migration

  def change do
    alter table(:crimes) do
      modify :latitude, :decimal, precision: 15, scale: 3
      modify :longitude, :decimal, precision: 15, scale: 3
    end
  end
end
