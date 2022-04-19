class Station

  attr_reader :trains, :station_name
   
  def initialize(station)
    @station_name = station
    @trains = []
  end

  def train_comes(train)
    @trains << train
  end

  def trains_by(type)
    @trains.select {|train| type == train.type}    
  end

  def count_trains_by(type)
    self.trains_by(type).length    
  end

  def train_leaves(train)
    @trains.delete(train)
  end

  def station_index(route) #public хотя не нужен пользователю, но используется в другом классе в открытом методе (вперед/назад поезд)
    route.list_of_stations.index(self)
  end
end
