defmodule CrimemapWeb.CrimeController do
  use CrimemapWeb, :controller

  alias Crimemap.Crimes
  alias Crimemap.Crimes.Crime
  alias Crimemap.Accounts

  defp get_user_from_conn(conn) do
    current_user = get_session(conn, :current_user_id)

    user = try do
      Accounts.get_user!(current_user)
    rescue
      _ in Ecto.NoResultsError -> %Accounts.User{}
    end

    user
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    changeset = Crimes.change_crime(%Crime{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crime" => crime_params}) do
    user = get_user_from_conn(conn)

    crime_params = Map.put(crime_params, "user_id", user.id)

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
    user = get_user_from_conn(conn)

    crime = Crimes.get_crime!(id)
    if crime.user_id != user.id do
      put_status(conn, 403)
        |> render(CrimemapWeb.ErrorView, "403.json", %{message: "This crime was sent by another user."})
    else
      changeset = Crimes.change_crime(crime)
      render(conn, "edit.html", crime: crime, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "crime" => crime_params}) do
    user = get_user_from_conn(conn)

    crime = Crimes.get_crime!(id)

    if crime.user_id != user.id do
      put_status(conn, 403)
        |> render(CrimemapWeb.ErrorView, "403.json", %{message: "This crime was sent by another user."})
    else
      case Crimes.update_crime(crime, crime_params) do
        {:ok, crime} ->
          conn
          |> put_flash(:info, "Crime updated successfully.")
          |> redirect(to: Routes.crime_path(conn, :show, crime))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", crime: crime, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    user = get_user_from_conn(conn)

    crime = Crimes.get_crime!(id)

    if crime.user_id != user.id do
      put_status(conn, 403)
        |> render(CrimemapWeb.ErrorView, "403.json", %{message: "This crime was sent by another user."})
    else
      {:ok, _crime} = Crimes.delete_crime(crime)

      conn
      |> put_flash(:info, "Crime deleted successfully.")
      |> redirect(to: Routes.crime_path(conn, :index))
    end
  end
end
