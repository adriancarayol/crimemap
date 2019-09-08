defmodule Crimemap.Repo.Migrations.LongAndLatDecimalWithoutPrecision do
  use Ecto.Migration

  def change do
    alter table(:crimes) do
      remove :latitude
      remove :longitude
    end
  end
end
