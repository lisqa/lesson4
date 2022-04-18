require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'wagon'
require_relative 'passengerwagon'
require_relative 'cargowagon'

class Interface

  attr_accessor :stations, :trains, :route, :first, :last, :current

  def initialize 
    @stations = []    
    @trains = []
  end
  
  def station_create
    puts "Ввeдите название станции"
    station = Station.new(gets.chomp)
    @stations << station
    self.interface
  end

  def train_create
    puts "Введите номер поезда"
    number = gets.chomp   
    puts "Грузовой или пассажирский? 1 - грузовой, 2 - пассажирский"
    gets.chomp == "1" ? train = CargoTrain.new(number) : train = PassengerTrain.new(number)
    @trains << train
    self.interface
  end

  def route_create
    puts "1 - создать маршрут, 2 - добавить станцию, 3 - удалить"
    choice = gets.chomp.to_i
    case choice
      when 1
        puts "Введите названия начальной и конечной станций из списка:"
        @stations.each { |station| print "#{station.station_name}, " }
        print "\n"
        first_station, last_station = gets.chomp, gets.chomp
        @stations.each { |station| @first = station if station.station_name == first_station }
        @stations.each { |station| @last = station if station.station_name == last_station }     
        @route = Route.new(@first, @last)
        puts "Ваш маршрут #{route.list_of_stations}"
      when 2 
        puts "Введите название промежуточной станции, которую надо добавить"
        station_dop = gets.chomp
        @stations.each { |station| @route.add_station(station) if station.station_name == station_dop }        
        puts "Ваш маршрут #{route.list_of_stations}"
      when 3
        puts "Введите название промежуточной станции, которую надо удалить"
        station_dop = gets.chomp
        @stations.each { |station| @route.remove_station(station) if station.station_name == station_dop }        
        puts "Ваш маршрут #{route.list_of_stations}"
      else
        self.interface
    end
    self.interface
  end

  def train_on_route
    puts "Выберите номер поезда из списка:"
    @trains.each { |train| print "#{train.number} - #{train.type}, "}
    print "\n"
    number = gets.chomp
    @trains.each { |train| train.train_on_route(@route) if train.number == number }        
    puts "Поезду номер #{number} назначен маршрут #{@route.list_of_stations}"
  end

  def train_add_wagon
    puts "Выберите номер поезда, которому надо прицепить вагон, из списка:"
    @trains.each { |train| print "#{train.number} - #{train.type}, "}
    print "\n"
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
    puts "Выберите номер поезда, у которого надо отцепить последний вагон, из списка:"
    @trains.each { |train| print "#{train.number} - #{train.type}, "}
    print "\n"
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
    puts "Выберите номер поезда, который поедет, из списка:"
    @trains.each { |train| print "#{train.number} - #{train.type}, "}
    print "\n"
    number = gets.chomp
    @trains.each { |train| 
      if train.number == number        
        puts "Куда едем? 1 - вперед, 2 - назад"
        gets.chomp.to_i == 1 ? train.go_next : train.go_back
        @current = train.current_station
      end
    }
    puts "Поезд номер #{number} прибыл на станцию #{@current.station_name}"
  end

  def list_of_stations_and_trains
    @stations.each { |station| puts "#{station.station_name} - #{station.trains}" }
  end

  def interface
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
          self.station_create
        when 2      
          self.train_create
        when 3
          self.route_create        
        when 4
          self.train_on_route
        when 5
          self.train_add_wagon
        when 6
          self.train_remove_wagon
        when 7
          self.train_go
        when 8
          self.list_of_stations_and_trains        
      end
    end
  end
end
