defmodule Crimemap.Repo.Migrations.UserNotNull do
  use Ecto.Migration

  def up do
    drop constraint(:crimes, "crimes_user_id_fkey")
    alter table(:crimes) do
      modify :user_id, references(:users, on_delete: :delete_all), null: false
    end
  end

  def down do
    drop constraint(:crimes, "crimes_user_id_fkey")
    alter table(:crimes) do
      modify :user_id, references(:users, on_delete: :nothing)
    end
  end

end
