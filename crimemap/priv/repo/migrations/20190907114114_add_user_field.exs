defmodule Crimemap.Repo.Migrations.AddUserField do
  use Ecto.Migration

  def change do
    alter table(:crimes) do
      add :user_id, references("users")
    end
  end
end
