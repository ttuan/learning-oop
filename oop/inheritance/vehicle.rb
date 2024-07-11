class Vehicle
  attr_accessor :make, :model, :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def start_engine
    puts "#{@make} #{@model} engine started"
  end

  def stop_engine
    puts "#{@make} #{@model} engine stopped"
  end
end

class Car < Vehicle
  attr_accessor :num_doors

  def initialize(make, model, year, num_doors)
    super(make, model, year)
    @num_doors = num_doors
  end

  def open_doors
    puts "Opening #{@num_doors} doors"
  end
end

class Bike < Vehicle
  attr_accessor :type_bike

  def initialize(make, model, year, type_bike)
    super(make, model, year)
    @type_bike = type_bike
  end

  def ring_bell
    puts "Ring ring!"
  end
end

# Usage
car = Car.new("Toyota", "Camry", 2020, 4)
bike = Bike.new("Trek", "Marlin 7", 2021, "Mountain Bike")

car.start_engine
car.open_doors
car.stop_engine

bike.start_engine
bike.ring_bell
bike.stop_engine
