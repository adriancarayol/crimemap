defmodule CrimemapWeb.API.CrimeController do
    use CrimemapWeb, :controller
    alias Crimemap.Crimes

    @spec index(Plug.Conn.t(), nil | keyword | map) :: Plug.Conn.t()
    def index(conn, params) do
        lat1 = String.to_float params["lat1"]
        lng1 = String.to_float params["lng1"]
        lat2 = String.to_float params["lat2"]
        lng2 = String.to_float params["lng2"]

        crimes = Crimes.list_crimes_between_bounds({lat1, lng1, lat2, lng2})
        render(conn, "index.json", crimes: crimes)
    end

end
