defmodule Crimemap.Crimes do
  @moduledoc """
  The Crimes context.
  """

  import Ecto.Query, warn: false
  alias Crimemap.Repo

  alias Crimemap.Crimes.Crime

  @doc """
  Returns the list of crimes.

  ## Examples

      iex> list_crimes()
      [%Crime{}, ...]

  """
  def list_crimes do
    Repo.all(Crime)
  end

  @doc """
  Gets a single crime.

  Raises `Ecto.NoResultsError` if the Crime does not exist.

  ## Examples

      iex> get_crime!(123)
      %Crime{}

      iex> get_crime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_crime!(id), do: Repo.get!(Crime, id)

  @doc """
  Creates a crime.

  ## Examples

      iex> create_crime(%{field: value})
      {:ok, %Crime{}}

      iex> create_crime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_crime(attrs \\ %{}) do
    %Crime{}
    |> Crime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a crime.

  ## Examples

      iex> update_crime(crime, %{field: new_value})
      {:ok, %Crime{}}

      iex> update_crime(crime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_crime(%Crime{} = crime, attrs) do
    crime
    |> Crime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Crime.

  ## Examples

      iex> delete_crime(crime)
      {:ok, %Crime{}}

      iex> delete_crime(crime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_crime(%Crime{} = crime) do
    Repo.delete(crime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking crime changes.

  ## Examples

      iex> change_crime(crime)
      %Ecto.Changeset{source: %Crime{}}

  """
  def change_crime(%Crime{} = crime) do
    Crime.changeset(crime, %{})
  end

  def list_crimes_between_bounds(bound, srid \\ 4326) do
    {lat1, lng1, lat2, lng2} = bound
    Ecto.Adapters.SQL.query!(Crimemap.Repo, "SELECT * FROM crimes WHERE crimes.point && ST_MakeEnvelope($1, $2, $3, $4, $5);", [lat1, lng1, lat2, lng2, srid])
  end
end
