class Schedule
  def scheduled?(schedulable, start_date, end_date)
  end

  def add(target, starting, ending)
    # target could be Bicycle, Mechanic, Vehicle, ...
    # Now, Schedule is checking class to get `lead_day` and compare with starting, ending value
  end

  def remove(target, starting, ending)
  end
end

# ==============================================================================
# Pick class Bicycle, build schedulable interface for this class, and refactor it for others

class Schedule
  def scheduled?(schedulable, starting, ending)
    p "This #{schedulable.class} is available #{starting} - #{ending}"
  end
end

class Bicycle
  attr_reader :schedule, :size, :chain, :tire_size

  def initialize(**opts)
    @schedule = opts[:schedule] || Schedule.new
    # ...
  end

  # Return true if this bicycle is available during this interval
  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, ending)
  end

  # Return schedule's answer
  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # Return the number of lead_days before a bicycle can be scheduled.
  def lead_days
    1
  end
end

require 'date'
starting = Date.parse("2019/09/04")
ending = Date.parse("2019/09/10")
b = Bicycle.new
puts b.schedulable?(starting, ending)
# => This Bicycle is available 2019-09-03 - 2019-09-10 # => true

# => Above code resolve 'what the schedulable? method should do'
# Now we will refactor to put 'where this code should be'

# =============================================================================
class Schedule
  def scheduled?(schedulable, starting, ending)
    p "This #{schedulable.class} is available #{starting} - #{ending}"
  end
end

module Schedulable
  attr_writer :schedule

  def schedule
    @schedule ||= Schedule.new
  end

  def schedulable?(starting, ending)
    !scheduled?(starting - lead_days, endiing)
  end

  def scheduled?(starting, ending)
    schedule.scheduled?(self, starting, ending)
  end

  # includers may override
  def lead_days
    0
  end
end

class Bicycle
  include Schedulable

  def lead_days
    1
  end
end

class Vehicle
  include Schedulable

  def lead_days
    3
  end
end

class Mechanic
  include Schedulable

  def lead_days
    4
  end
end

require 'date'
starting = Date.parse("2019/09/04")
ending   = Date.parse("2019/09/10")
b = Bicycle.new
puts b.schedulable?(starting, ending)
# => This Bicycle is available 2019-09-03 - 2019-09-10 # => true
