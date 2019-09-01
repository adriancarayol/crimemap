defmodule CrimemapWeb.PageController do
  use CrimemapWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
