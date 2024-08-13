class Trip
  attr_reader :bicycles, :customers, :vehicle

  # this 'mechanic' arg could be of any class that responds to 'prepare_bicycles'
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
end

# if you happen to pass an instance of *this* class, it works
class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each { |bicycle| prepare_bicycle(bicycle) }
  end

  def prepare_bicycle(bicycle)
    #...
  end
end

# =========================================================
# when trip becomes bigger
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.preparer_bicles(bicycles)
      when TripCoordinator
        preparer.by_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    end
  end
end

class TripCoordinator
  def by_food(customers)
    #...
  end
end

class Driver
  def gas_up
  end

  def fill_water_tank
  end
end

# =========================================================
# Finding the Duck
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each { |preparer| preparer.prepare_trip(self) }
  end
end

# when every preparer is a Duck that responds to 'prepare_trip'
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each do |bicycle|
      prepare_bicycle(bicycle)
    end
  end
end

class TripCoordinator
  def prepare_trip(trip)
    by_food(trip.customers)
  end
end

class Driver
  def prepare_trip(trip)
    gas_up(trip.vehicle)
    fill_water_tank(trip.vehicle)
  end
end
