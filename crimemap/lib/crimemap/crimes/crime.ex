defmodule Crimemap.Crimes.Crime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "crimes" do
    field :details, :string
    field :title, :string
    field :point, Geo.PostGIS.Geometry
    field :validated, :boolean, default: false
    field :validation_msg, :string

    # Virtuals fields
    field :longitude, :decimal, virtual: true
    field :latitude, :decimal, virtual: true
    # Associations
    belongs_to :user, Crimemap.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(crime, attrs) do
    crime
    |> cast(attrs, [:details, :title, :validated, :validation_msg, :user_id])
    |> assoc_constraint(:user)
    |> validate_required([:details, :title, :validated, :validation_msg])
    |> long_and_lat_to_point
  end

  defp long_and_lat_to_point(changeset) do
    longitude = get_change(changeset, :longitude)
    latitude = get_change(changeset, :latitude)

    if longitude && latitude do
      point = %Geo.Point{coordinates: {longitude, latitude}, srid: 4326}
      put_change(changeset, :point, point)
    else
      changeset
    end
  end
end
