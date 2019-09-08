defmodule CrimemapWeb.CrimeControllerTest do
  use CrimemapWeb.ConnCase

  alias Crimemap.Crimes
  alias Crimemap.Accounts

  @valid_user_attrs %{email: "email@es.es", password: "some encrypted_password", username: "username"}
  @create_attrs %{details: "some details", latitude: 42, longitude: 42, title: "some title", validated: true, validation_msg: "some validation_msg"}
  @update_attrs %{details: "some updated details", latitude: 43, longitude: 43, title: "some updated title", validated: false, validation_msg: "some updated validation_msg"}
  @invalid_attrs %{details: nil, latitude: nil, longitude: nil, title: nil, validated: nil, validation_msg: nil}

  def fixture(:crime) do
    {:ok, user} = Accounts.create_user(@valid_user_attrs)
    attrs_with_user = Map.put(@create_attrs, :user_id, user.id)
    {:ok, crime} = Crimes.create_crime(attrs_with_user)
    crime
  end

  describe "index" do
    test "lists all crimes", %{conn: conn} do
      conn = get(conn, Routes.crime_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Crimes"
    end
  end

  describe "new crime" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.crime_path(conn, :new))
      assert html_response(conn, 200) =~ "New Crime"
    end
  end

  describe "create crime" do
    test "redirects to show when data is valid", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@valid_user_attrs)

      conn = post(conn, Routes.crime_path(conn, :create), crime: Map.put(@create_attrs, :user_id, user.id))

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.crime_path(conn, :show, id)

      conn = get(conn, Routes.crime_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Crime"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.crime_path(conn, :create), crime: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Crime"
    end
  end

  describe "edit crime" do
    setup [:create_crime]

    test "renders form for editing chosen crime", %{conn: conn, crime: crime} do
      conn = get(conn, Routes.crime_path(conn, :edit, crime))
      assert html_response(conn, 200) =~ "Edit Crime"
    end
  end

  describe "update crime" do
    setup [:create_crime]

    test "redirects when data is valid", %{conn: conn, crime: crime} do
      conn = put(conn, Routes.crime_path(conn, :update, crime), crime: @update_attrs)
      assert redirected_to(conn) == Routes.crime_path(conn, :show, crime)

      conn = get(conn, Routes.crime_path(conn, :show, crime))
      assert html_response(conn, 200) =~ "some updated details"
    end

    test "renders errors when data is invalid", %{conn: conn, crime: crime} do
      conn = put(conn, Routes.crime_path(conn, :update, crime), crime: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Crime"
    end
  end

  describe "delete crime" do
    setup [:create_crime]

    test "deletes chosen crime", %{conn: conn, crime: crime} do
      conn = delete(conn, Routes.crime_path(conn, :delete, crime))
      assert redirected_to(conn) == Routes.crime_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.crime_path(conn, :show, crime))
      end
    end
  end

  defp create_crime(_) do
    crime = fixture(:crime)
    {:ok, crime: crime}
  end
end
