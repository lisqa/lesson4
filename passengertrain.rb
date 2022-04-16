require_relative 'train'

class PassengerTrain < Train
  attr_accessor :wagon

  def initialize(number, type = "passenger")
    @number = number.to_s 
    @type = type
    super
  end

  def add_wagons(wagon)
    super if wagon.type == "passenger"
  end  
end
