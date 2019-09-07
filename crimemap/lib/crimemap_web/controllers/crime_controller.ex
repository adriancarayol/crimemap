defmodule CrimemapWeb.CrimeController do
  use CrimemapWeb, :controller

  alias Crimemap.Crimes
  alias Crimemap.Crimes.Crime

  def index(conn, _params) do
    crimes = Crimes.list_crimes()
    render(conn, "index.html", crimes: crimes)
  end

  def new(conn, _params) do
    changeset = Crimes.change_crime(%Crime{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crime" => crime_params}) do
    case Crimes.create_crime(crime_params) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime created successfully.")
        |> redirect(to: Routes.crime_path(conn, :show, crime))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crime = Crimes.get_crime!(id)
    render(conn, "show.html", crime: crime)
  end

  def edit(conn, %{"id" => id}) do
    crime = Crimes.get_crime!(id)
    changeset = Crimes.change_crime(crime)
    render(conn, "edit.html", crime: crime, changeset: changeset)
  end

  def update(conn, %{"id" => id, "crime" => crime_params}) do
    crime = Crimes.get_crime!(id)

    case Crimes.update_crime(crime, crime_params) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime updated successfully.")
        |> redirect(to: Routes.crime_path(conn, :show, crime))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", crime: crime, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crime = Crimes.get_crime!(id)
    {:ok, _crime} = Crimes.delete_crime(crime)

    conn
    |> put_flash(:info, "Crime deleted successfully.")
    |> redirect(to: Routes.crime_path(conn, :index))
  end
end
