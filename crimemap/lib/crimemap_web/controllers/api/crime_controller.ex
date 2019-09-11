defmodule CrimemapWeb.API.CrimeController do
    use CrimemapWeb, :controller
    alias Crimemap.Crimes

    def index(conn, _params) do
        lat1 = String.to_float _params["lat1"]
        lng1 = String.to_float _params["lng1"]
        lat2 = String.to_float _params["lat2"]
        lng2 = String.to_float _params["lng2"]

        crimes = Crimes.list_crimes_between_bounds({lat1, lng1, lat2, lng2})
        render(conn, "index.json", crimes: crimes)
    end

end