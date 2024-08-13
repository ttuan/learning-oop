class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args)
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    {tire_size: tire_size, chain: chain}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  def post_initialize(opts)
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    "23"
  end
end
