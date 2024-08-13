module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_responds_to_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_tire_size
    assert_respond_to(@object, :tire_size)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end
end

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = RoadBike.new
  end
end

# =============================================================================
# Test bicycle subclasses
module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new
  end


  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end

class MountainBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end
end

# =============================================================================
# Test Abstract Class
class BikeDouble < Bicycle
  def default_tire_size
    0
  end

  def local_spares
    { saddle: 'painful' }
  end
end

class BicycleTest < Minitest::Test
  include BicycleInterfaceTest

  def setup
    @bike = @object = Bicycle.new(tire_size: 0)
    @double = BikeDouble.new
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) {@bike.default_tire_size}
  end

  def test_includes_local_spare_in_spares
    assert_equal @double.spares, { tire_size: 0, chain: '11-speed', saddle: 'painful' }
  end
end

class BikeDoubleTest < Minitest::Test
  include BicycleSubclassTest

  def setup
    @object = BikeDouble.new
  end
end
