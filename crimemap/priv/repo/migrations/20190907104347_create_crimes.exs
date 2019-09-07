defmodule Crimemap.Repo.Migrations.CreateCrimes do
  use Ecto.Migration

  def change do
    create table(:crimes) do
      add :latitude, :integer
      add :longitude, :integer
      add :details, :string
      add :title, :string
      add :validated, :boolean, default: false, null: false
      add :validation_msg, :string

      timestamps()
    end

  end
end
