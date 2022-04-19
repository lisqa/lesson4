class Route

  attr_accessor :list_of_stations
 
  def initialize(first_station, end_station)
    @list_of_stations = [first_station, end_station]
  end

  def add_station(station)
    @list_of_stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @list_of_stations[0] && station != @list_of_stations[-1]
      @list_of_stations.delete(station)
    end
  end
end
