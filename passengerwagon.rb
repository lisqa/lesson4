require_relative 'wagon'

class PassengerWagon < Wagon
  def type
    @type = "passenger"
  end
end
