require_relative 'train'

class PassengerTrain < Train

  def initialize(number, type = "passenger")
    @number = number.to_s 
    @type = type
    super
  end
end
