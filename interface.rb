require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'wagon'
require_relative 'passengerwagon'
require_relative 'cargowagon'

class Interface

private

  attr_accessor :stations, :trains, :route, :routes 

  def initialize 
    @stations = []    
    @trains = []
    @routes = []
  end
  
  def station_create
    puts "Ввeдите название станции"
    station = Station.new(gets.chomp)
    @stations << station
    puts "Станция #{station.station_name} создана"
    self.run
  end

  def train_create
    puts "Введите номер поезда"
    number = gets.chomp   
    puts "Грузовой или пассажирский? 1 - грузовой, 2 - пассажирский"
    gets.chomp == "1" ? train = CargoTrain.new(number) : train = PassengerTrain.new(number)
    @trains << train
    puts "Поезд номер #{number} - #{train.type} создан"
    self.run
  end

  def route_create
    puts "1 - создать маршрут, 2 - добавить станцию, 3 - удалить"
    choice = gets.chomp.to_i
    case choice
      when 1
        puts "Введите названия начальной и конечной станций"
        first_station, last_station = gets.chomp, gets.chomp 
        route = Route.new(@stations.find { |station| station if station.station_name == first_station }, @stations.find { |station| station if station.station_name == last_station })
        @routes << route
        puts "Маршрут создан #{route.list_of_stations}"
      when 2 
        self.route
        puts "Введите название промежуточной станции, которую надо добавить"
        station_dop = gets.chomp
        @stations.each { |station| @route.add_station(station) if station.station_name == station_dop }        
        puts "Маршрут изменен"
      when 3
        self.route
        puts "Введите название промежуточной станции, которую надо удалить"
        station_dop = gets.chomp
        @stations.each { |station| @route.remove_station(station) if station.station_name == station_dop }        
        puts "Маршрут изменен"
      else
        self.run
    end
    self.run
  end

  def train_route
    self.route
    puts "Введите номер поезда, которому надо назначить маршрут"
    number = gets.chomp
    @trains.each { |train| train.train_route(@route) if train.number == number }
    puts "Поезду номер #{number} назначен маршрут"
  end

  def train_add_wagon
    puts "Введите номер поезда, которому надо прицепить вагон"
    number = gets.chomp
    @trains.each { |train| 
      if train.number == number   
        if train.type == "passenger" ? wagon = PassengerWagon.new : wagon = CargoWagon.new
          train.stop
          train.add_wagons(wagon)
        end
      end
    }
    puts "Поезду номер #{number} прицеплен вагон"
  end
    
  def train_remove_wagon
    puts "Введите номер поезда, у которого надо отцепить последний вагон"
    number = gets.chomp
    @trains.each { |train| 
      if train.number == number
        train.stop
        train.remove_wagons(train.wagons[-1])
      end
    }
    puts "У поезда номер #{number} отцеплен вагон"
  end

  def train_go
    puts "Введите номер поезда, который поедет"
    number = gets.chomp
    @trains.each { |train| 
      if train.number == number        
        puts "Куда едем? 1 - вперед, 2 - назад"
        gets.chomp.to_i == 1 ? train.go_next : train.go_back
      end
    }
    puts "Поезд #{number} прибыл на станцию"
  end

  def list_of_stations_and_trains
    puts "Список станций и поездов на них:"
    @stations.each { |station| 
      puts "На станции #{station.station_name} находятся поезда: "
      station.trains.each { |train| puts "#{train.number}-#{train.type}"}
    }
  end

public

  def run
    loop do      
      puts "Выберите, что вы хотите сделать 
      1 - создать станцию 
      2 - создать поезд 
      3 - создать маршрут, добавить/удалить станции в маршруте
      4 - назначить маршрут поезду
      5 - прицепить вагон к поезду
      6 - отцепить вагон от поезда
      7 - переместить поезд на одну станцию (вперед или назад)
      8 - посмотреть список станций и список поездов на станции
      0 - ничего не хочу делать"
      create = gets.chomp.to_i
      break if create == 0  #выходит только со второго ввода
      case create
        when 1
          station_create
        when 2      
          train_create
        when 3
          route_create        
        when 4
          train_route
        when 5
          train_add_wagon
        when 6
          train_remove_wagon
        when 7
          train_go
        when 8
          list_of_stations_and_trains        
      end
    end
  end

  def route
    puts "Выберите маршрут - введите названия начальной и конечно станций"
    first_station, last_station = gets.chomp, gets.chomp
    @routes.each { |route| @route = route if route.list_of_stations[0] == @stations.find { |station| station if station.station_name == first_station } && route.list_of_stations[-1] == @stations.find { |station| station if station.station_name == last_station } }
  end
end
