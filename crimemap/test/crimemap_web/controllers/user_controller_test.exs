defmodule CrimemapWeb.UserControllerTest do
  use CrimemapWeb.ConnCase

  alias Crimemap.Accounts

  @create_attrs %{email: "email@es.es", password: "password", password_confirmation: "password", username: "username"}
  @invalid_attrs %{email: nil, password: nil, username: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "Register"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :show)

      conn = get(conn, Routes.user_path(conn, :show))
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "something went wrong!"
    end
  end
end
