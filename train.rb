class Train
  
  attr_accessor :speed, :number, :type, :wagons, :train_route, :train_station

  def initialize(number, type)
    @number = number.to_s 
    @type = type
    @wagons = []
  end

  def go(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagons(wagon)
    @wagons << wagon if @speed == 0
  end

  def remove_wagons(wagon)
    @wagons.delete(wagon) if @speed == 0 
  end

  def train_on_route(route)  
    @train_route = route 
    @train_station = @train_route.list_of_stations[0]
    @train_station.train_comes(self)
  end
  
  def current_station 
    @train_route.list_of_stations[station_number(@train_station)] 
  end

  def go_next 
    if @train_station != @train_route.list_of_stations[-1] #проверка не конечная ли станция?
       @train_station.train_leaves(self)
       @train_station = self.next_station     #текущая станция меняется на следующую станцию
       @train_station.train_comes(self)
    else 
      @train_station = self.current_station
    end
  end

  def go_back
    if station_number(@train_station) > 0
      @train_station.train_leaves(self)
      @train_station = self.back_station
      @train_station.train_comes(self)
    else 
      @train_station = self.current_station
    end
  end

  def next_station 
    @train_route.list_of_stations[station_number(@train_station)+1] if @train_station != @train_route.list_of_stations[-1]
  end

  def back_station
    @train_route.list_of_stations[station_number(@train_station)-1] if station_number(@train_station) > 0
  end  
  
  def station_number(station) 
    station.station_index(@train_route)
  end
end
