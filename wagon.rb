class Wagon
  attr_accessor :type
end

class PassengerWagon < Wagon
  def type
    @type = "passenger"
  end
end

class CargoWagon < Wagon 
  def type
    @type = "cargo"
  end
end
