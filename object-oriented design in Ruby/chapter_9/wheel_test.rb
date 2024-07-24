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
