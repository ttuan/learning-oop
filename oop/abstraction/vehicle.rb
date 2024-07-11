# Abstract class module
module Vehicle
  def start_engine
    raise NotImplementedError, "This method must be implemented in the subclass"
  end

  def stop_engine
    raise NotImplementedError, "This method must be implemented in the subclass"
  end
end

class Car
  include Vehicle

  def start_engine
    puts "Car engine started"
  end

  def stop_engine
    puts "Car engine stopped"
  end
end

class Motorcycle
  include Vehicle

  def start_engine
    puts "Motorcycle engine started"
  end

  def stop_engine
    puts "Motorcycle engine stopped"
  end
end

# Client code
vehicles = [Car.new, Motorcycle.new]
vehicles.each do |vehicle|
  vehicle.start_engine
  vehicle.stop_engine
end


# Source code without abstraction
class Car
  def start_engine
    puts "Car engine started"
  end

  def stop_engine
    puts "Car engine stopped"
  end
end

class Motorcycle
  def start_engine
    puts "Motorcycle engine started"
  end

  def stop_engine
    puts "Motorcycle engine stopped"
  end
end

# Client code
vehicles = [Car.new, Motorcycle.new]
vehicles.each do |vehicle|
  if vehicle.is_a?(Car)
    vehicle.start_engine
    vehicle.stop_engine
  elsif vehicle.is_a?(Motorcycle)
    vehicle.start_engine
    vehicle.stop_engine
  end
end

