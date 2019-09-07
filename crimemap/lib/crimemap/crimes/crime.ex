defmodule Crimemap.Crimes.Crime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crimes" do
    field :details, :string
    field :latitude, :integer
    field :longitude, :integer
    field :title, :string
    field :validated, :boolean, default: false
    field :validation_msg, :string
    
    # Associations
    belongs_to :user, Crimemap.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(crime, attrs) do
    crime
    |> cast(attrs, [:latitude, :longitude, :details, :title, :validated, :validation_msg])
    |> validate_required([:latitude, :longitude, :details, :title, :validated, :validation_msg])
    |> cast_assoc(:user)
  end

  def set_user_changeset(crime, user \\ %{}) do
    crime
    |> cast(user, [:user_id])
    |> cast_assoc(:user)
  end
end
