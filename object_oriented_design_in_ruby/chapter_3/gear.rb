# version 1
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end
end
# => Gear does not care and should not know about the class of that object.
# It is not necessary for Gear to know about the existence of the Wheel class in order to calculate gear_inches.
# It doesn't need to know that Wheel expects to be init with a rim and a tire; it just needs an object that know diameter

# ========================================================
# version 2 - Dependency Injection
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
end
# Gear expects a 'Duck' that knows 'diameter'


# ========================================================
# version 3
# Isolating instance creation
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# Isolate Vulnerable External Messages
class Gear
  # ....
  def gear_inches
    ratio * diameter
  end

  def diameter
    wheel.diameter
  end
end


# ========================================================
# version 4 - Keyword Arguments
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring:, cog:, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
  # ...
end
Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5))

# Adding args default
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring: 40, cog: 18, wheel:)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  # ...
end
Gear.new(wheel: Wheel.new(26, 1.5)).chainring

# Isolate Multiparameter Initialization
# When Gear is part of an external interface
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel

    def initialize(chainring, cog, wheel)
      @chanring = chainring
      @cog = cog
      @wheel = wheel
    end
  end
end
# Wrap the interface to protect yourself from changes
module GearWrapper
  def self.gear(chainring: , cog: , wheel:)
    SomeFramework::Gear.new(chainring, cog, wheel)
  end
end

puts GearWrapper.gear(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5)).gear_inches
