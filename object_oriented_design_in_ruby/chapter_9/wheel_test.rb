class WheelTest < Minitest::Test
  def test_calculates_diameter
    wheel = Wheel.new(26, 1.5)
    assert_in_delta(29, wheel.diameter, 0.01)
  end
end

class GearTest < Minitest::Test
  def tets_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      rim: 26,
      tire: 1.5
    )
    assert_in_delta(137.1, gear.gear_inches, 0.01)
  end
end
# => Problem: gear_inches call to Wheel.new. If Wheel changes, Gear must change.
# This test will fail if Wheel changes.
# => Solution: Inject Wheel into Gear. Gear no longer depends on Wheel.

# =============================================================================
# Inject Wheel into GearTest
class GearTest < Minitest::test
  def test_calculates_gear_inches
    wheel = Wheel.new(26, 1.5)
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: wheel
    )
    assert_in_delta(137.1, gear.gear_inches, 0.01)
  end
end

# =============================================================================
# Create a player of the 'Diameterizable' role
class DiameterDouble
  def diameter
    10
  end
end

class GearTest < Minitest::Test
  def test_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new
    )

    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end

# Force Wheel response method diameter
class WheelTest < Minitest::Test
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :diameter)
  end

  def test_calculates_diameter
    assert_in_delta(29, @wheel.diameter, 0.01)
  end
end

# =============================================================================
# Using Mock to test Command messages
class GearTest < Minitest::Test
  def setup
    @observer = Minitest::Mock.new
    @gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new,
      observer: @observer
    )
  end

  def test_notifies_observers_when_cogs_change
    @observer.expect(:changed, true, [52, 27])
    @gear.set_cog(27)
    @observer.verify
  end

  def test_notifies_observers_when_chainrings_change
    @observer.expect(:changed, true, [42, 11])
    @gear.set_chanring(42)
    @observer.verify
  end
end


# =============================================================================
# Use role
module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :width)
  end
end

class DiameterDouble
  def diameter
    10
  end
end

# Prove the test double honors the interface this test expects.
class DiameterDoubleTest < MiniTest::Unit::TestCase
  include DiameterizableInterfaceTest

  def setup
    @object = DiameterDouble.new
  end
end

class GearTest < MiniTest::Unit::TestCase
  def test_calculates_gear_inches
    gear = Gear.new(
      chainring: 52,
      cog: 11,
      wheel: DiameterDouble.new
    )

    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end
# This test will failed, cause interface test requires that the players need to implement "width" method, not "diameter"
