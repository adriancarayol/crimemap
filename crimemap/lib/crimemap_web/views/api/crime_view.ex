defmodule CrimemapWeb.API.CrimeView do
    use CrimemapWeb, :view
  
    def render("index.json", %{crimes: crimes}) do
        if crimes.rows do
            %{
                crimes: Enum.map(crimes.rows, &crime_json/1)
            }
        else
            []
        end
    end
    
    def crime_json(crime) do
        lat = Enum.at(crime, 8).coordinates
        |> Tuple.to_list
        |> Enum.at(1)

        lng = Enum.at(crime, 8).coordinates
        |> Tuple.to_list
        |> Enum.at(0)

        %{
            id: Enum.at(crime, 0),
            details: Enum.at(crime, 1),
            title: Enum.at(crime, 2),
            inserted_at: Enum.at(crime, 5),
            updated_at: Enum.at(crime, 6),
            user_id: Enum.at(crime, 7),
            lat: lat,
            lng: lng
        }
    end
  end