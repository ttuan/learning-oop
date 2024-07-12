# Basic case
class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    # number of teeth
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

# put Gear.new(52, 11).ratio
# puts Gear.new(30, 27).ratio

# =============================================================================
# Add gear_inches
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    # tire goes around rim twice for diameter
    ratio * (rim + (tire * 2))
  end
end

# puts Gear.new(52, 11, 26, 1.5).gear_inches
# Adding 2 args to Gear make old code (which is creating gear object with 2 args) is broken.
#
# To determine if a class has a single responsibility, asks some questions
# Please, Mr.Gear, what is your ratio? What are your gear inches?
# Please, Mr.Gear, what are your tire size??? => ridiculous

# =============================================================================
# Hide data structures
#
# Before
class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.collect { |cell| cell[0] + (cell[1] * 2) }
  end
end


# After refactoring
class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
  end

  # now everyone can send rim/tire to wheels
  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect { |cell| Wheel.new(cell[0], cell[1]) }
  end
end
# =============================================================================
