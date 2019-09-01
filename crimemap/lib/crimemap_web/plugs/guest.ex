defmodule CrimemapWeb.Plugs.Guest do
  import Plug.Conn
  import Phoenix.Controller
  alias CrimemapWeb.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if Plug.Conn.get_session(conn, :current_user_id) do
      conn
      |> redirect(to: Helpers.page_path(conn, :show))
      |> halt()
    end
    conn
  end
end
