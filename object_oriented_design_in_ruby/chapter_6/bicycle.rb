# Bicycle version 1
class Bicycle
  attr_reader :size, :tape_color

  def initialize(**opt)
    @size = opts[:size]
    @tape_color = opts[:tape_color]
  end

  # every bike has the same defaults for tire and chain size
  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
end

bike = Bicycle.new(size: 'M', tape_color: 'red')
puts bike.size
puts bike.spares

# =============================================================================
# Adding multiple bicycle types
class Bicycle
  attr_reader :style, :size, :tape_color, :front_shock, :rear_shock

  def initialize(**opts)
    @style = opts[:style]
    @size = opts[:size]
    @tape_color = opts[:tape_color]
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  # checking 'style' starts down a slippery slope
  def spares
    if style == :road
      {
        chain: '11-speed',
        tire_size: '23',
        tape_color: tape_color
      }
    else
      {
        chain: '11-speed',
        tire_size: '2.1',
        front_shock: front_shock
      }
    end
  end
end

bike = Bicycle.new(style: :mountain, size: 'S', front_shock: 'Mainitou', rear_shock: 'Fox')
p bike.spares

bike = Bicycle.new(style: :road, size: 'M', tape_color: 'red')
p bike.spares

# =============================================================================
# Misapplying Inheritance
class Bicycle
  attr_reader :size, :tape_color

  def initialize(**opts)
    @size = opts[:size]
    @tape_color = opts[:tape_color]
  end

  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
end

class MoutainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock)
  end
end

moutain_bike = MoutainBike.new(size: 'S', front_shock: 'Mainitou', rear_shock: 'Fox')
p moutain_bike.size
p moutain_bile.spares

# =============================================================================
# Create hierarchy
class Bicycle
  # This class is empty except for initialize. Code has been moved to RoadBike
end

class RoadBike < Bicycle
  # Now a subclass of Bicycle. Contains all code form the old Bicycle class
  def initialize(**opts)
    @size = opts[:size]
    @tape_color = opts[:tape_color]
  end

  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
end

class MountainBike < Bicycle
  # Still a subclass of Bicycle. Code has not changed.
  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock) # => This will raise error
  end
end
# This fixed behavior for Bicycle, but it makes MoutainBike behaviors incorrect

# =============================================================================
# Fixed behavior for MountainBike
# push-everything-down-and-then-pull-some-things-up
# Now we push everything down to RoadBike. It's time to pull 'size' up
class Bicycle
  attr_reader :size

  def initialize(**opts)
    @size = opts[:size]
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts
    super
  end

  def spares
    {
      chain: '11-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
end

class MoutainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock) # => This will raise error
  end
end

# =============================================================================
# Template methods pattern
class Bicycle
  attr_reader :size

  def initialize(**opt)
    @size = opt[:size]
    @chain = opt[:chain] || default_chain
    @tire_size = opt[:type_size] || default_tire_size
  end

  def default_chain
    "11-speed"
  end

  def default_tire_size
    raise NotImplementedError, "#{self.class} should have implemented ..."
  end
end

class RoadBike < Bicycle
  def default_tire_size
    "23"
  end
end

class MoutainBike < Bicycle
  def default_tire_size
    "2.1"
  end
end

#==============================================================================
# Implement spares method in Bicycle
class Bicycle
  attr_reader :size

  def initialize(**opt)
    @size = opt[:size]
    @chain = opt[:chain] || default_chain
    @tire_size = opt[:type_size] || default_tire_size
  end

  def default_chain
    "11-speed"
  end

  def default_tire_size
    raise NotImplementedError, "#{self.class} should have implemented ..."
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain
    }
  end
end


class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(**opts)
    @tape_color = opts[:tape_color]
    super
  end

  def spares
    super.merge(tape_color: tape_color)
  end

  def default_tire_size
    "23"
  end
end

class MoutainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(**opts)
    front_shock = opts[:front_shock]
    rear_shock = opts[:rear_shock]
    super
  end

  def spares
    super.merge(front_shock: front_shock)
  end

  def default_tire_size
    "2.1"
  end
end

# It works. But it still has a trap.
# Currently, sub-classes is sending 'super' to call init function in super-class. It's mean sub-classes know how their parent do the other things.
# Knowing things about other classes, as always, creates dependencies, and dependencies couple objects together.
# What if a sub-class forgot 'super'?

class RecumbentBike < Bicycle
  attr_reader :flag

  def initialize(**opts)
    @flag = opts[:flag] # => Forgot to send 'super'
  end

  def spares
    super.merge(flag: flag)
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    '28'
  end
end

#==============================================================================
# Decouple subclasses using hook messages 👍
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(**opts)
    @size = opts[:size]
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size

    post_initialize(opts)
  end

  def spares
    {
      tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  def default_chain
    '11-speed'
  end

  def local_spares
    {}
  end

  def post_initialize(opts)
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    {
      tape_color: tape_color
    }
  end

  def default_tire_size
    "23"
  end
end

class MoutainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  def local_spares
    { front_shock: front_shock }
  end

  def default_tire_size
    '2.1'
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(opts)
    @flag = opts[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    '28'
  end
end
