require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'wagon'
#require_relative 'passengerwagon'
#require_relative 'cargowagon'


=begin
- Создавать станции
- Создавать поезда
- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
- Назначать маршрут поезду
- Добавлять вагоны к поезду
- Отцеплять вагоны от поезда
- Перемещать поезд по маршруту вперед и назад
- Просматривать список станций и список поездов на станции  
=end

#Честно говоря, не поняла, что подразумевается под "создать пользовательский интерфейс"

first_station = Station.new(first_station)  # Создание начальной станции 
end_station = Station.new(end_station)  # Создание конечной станции 
station1 = Station.new(station1)  # Создание промежуточной станции_1
station2 = Station.new(station2)  # Создание промежуточной станции_2
train_pass = PassengerTrain.new(train_pass)  #Создание пассажирского поезда номер train_pass 
train_cargo = CargoTrain.new(train_cargo)  #Создание грузового поезда номер train_cargo
route = Route.new(first_station, end_station) #Создание маршрута от начальной до конечной станции
route.add_station(station1)   #Добавление в маршрут промежуточной станции_1
route.add_station(station2)   #Добавление в маршрут промежуточной станции_2
route.remove_station(station1)   #Удаление из маршрута промежуточной станции_1
train_pass.train_route(route)  #Назначение маршрута пассажирскому поезду
train_cargo.train_route(route)  #Назначение маршрута грузовому поезду
passwagon = PassengerWagon.new 
train_pass.add_wagons(passwagon)    #Добавление вагона пассажирскому поезду
cargowagon = CargoWagon.new     
train_cargo.add_wagons(cargowagon)    #Добавление вагона грузовому поезду
train_pass.remove_wagons(passwagon)    #Отцепление вагона у пассажирского поезда
train_cargo.remove_wagons(cargowagon)    #Отцепление вагона у грузового поезда
train_pass.go_next        #Перемещение пассажирского поезда по маршруту вперед на одну станцию
train_cargo.go_next        #Перемещение пассажирского поезда по маршруту вперед на одну станцию
train_pass.go_back        #Перемещение пассажирского поезда по маршруту назад на одну станцию
train_cargo.go_back        #Перемещение грузового поезда по маршруту назад на одну станцию
route.list_of_stations  # Просмотр станций на маршруте
first_station.trains # Просмотр поездов на начальной станции (только их там нет... пункта "поместить поезда на станцию" в задании нет)
end_station.trains # Просмотр поездов на конечной станции (только их там  тоже нет... )
