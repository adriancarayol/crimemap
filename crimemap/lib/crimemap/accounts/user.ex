defmodule Crimemap.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Crimemap.Accounts.Encryption


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string

    # Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email,])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> validate_format(:username, ~r/^[a-z0-9][a-z0-9]+[a-z0-9]$/i)
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:username, min: 6)
    |> lowercase_username
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.encrypt_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      changeset
    end
  end

  defp lowercase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)
  end
end
