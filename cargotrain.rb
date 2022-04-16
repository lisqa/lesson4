require_relative 'train'

class CargoTrain < Train
  
  def initialize(number, type = "cargo")
    @number = number.to_s 
    @type = type
    super
  end

  def add_wagons(wagon)
    super if wagon.type == "cargo"
  end
end
