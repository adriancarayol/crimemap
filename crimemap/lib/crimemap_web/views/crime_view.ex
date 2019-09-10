defmodule CrimemapWeb.CrimeView do
  use CrimemapWeb, :view

  def parse_latitude(point) do
    coordinates = Tuple.to_list(point.coordinates)
    "#{List.first(coordinates)}"
  end

  def parse_longitude(point) do
    coordinates = Tuple.to_list(point.coordinates)
    "#{List.last(coordinates)}"
  end

end
