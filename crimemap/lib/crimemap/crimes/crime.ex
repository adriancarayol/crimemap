defmodule Crimemap.Crimes.Crime do
  use Ecto.Schema
  import Ecto.Changeset

  @srid 4326

  schema "crimes" do
    field :details, :string
    field :title, :string
    field :point, Geo.PostGIS.Geometry
    field :validated, :boolean, default: false
    field :validation_msg, :string, default: ""

    # Virtuals fields
    field :longitude, :string, virtual: true
    field :latitude, :string, virtual: true
    # Associations
    belongs_to :user, Crimemap.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(crime, attrs) do
    crime
    |> cast(attrs, [:details, :title, :validated, :validation_msg, :longitude, :latitude, :user_id])
    |> assoc_constraint(:user)
    |> validate_required([:details, :title, :longitude, :latitude])
    |> parse_lat
    |> parse_long
    |> create_point
  end

  defp parse_lat(changeset) do
    update_change(changeset, :latitude, &String.to_float/1)
  end

  defp parse_long(changeset) do
    update_change(changeset, :longitude, &String.to_float/1)
  end

  defp create_point(changeset) do
    longitude = get_change(changeset, :longitude)
    latitude = get_change(changeset, :latitude)

    if longitude && latitude do
      point = %Geo.Point{coordinates: {longitude, latitude}, srid: @srid}
      put_change(changeset, :point, point)
    else
      changeset
    end
  end

end
