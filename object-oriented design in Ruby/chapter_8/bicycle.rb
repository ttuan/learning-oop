# Origin of Bicycle
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

# ==========================================================================
# Inject parts into the Bicycle class
class Bicycle
  attr_reader :size, :parts

  def initialize(**opts)
    @size = opts[:size]
    @parts = opts[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :chain, :tire_size

  def initialize(**opts)
    @chain = opts[:chain] || default_chain
    @tire_size = opts[:tire_size] || default_tire_size

    post_initialize(opts)
  end

  def spares
    {chain: chain, tire_size: tire_size}.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def post_initialize(opts)
    nil
  end

  def local_spares
    {}
  end

  def default_chain
    "11-speed"
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(**opts)
    @tape_color = opts[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size
    "23"
  end
end

class MoutainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(**opts)
    @front_shock = opts[:front_shock]
    @rear_shock = opts[:rear_shock]
  end

  def local_spares
    { front_shock: front_shock }
  end

  def default_tire_size
    "2.1"
  end
end

road_bike = Bicycle.new( size: "L", parts: RoadBikeParts.new(tape_color: "red"))
p road_bike.spares

#==========================================================================
# Split Parts into Part
class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size = size
    @parts = parts
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(name: , description:, needs_spare: true)
    @name = name
    @description = description
    @needs_spare = needs_spare
  end
end

chain = Part.new(name: "chain", description: "11-speed")
road_tire = Part.new(name: "tire_size", description: "23")
tape = Part.new(name: "tape_color", description: "red")
moutain_tire = Part.new(name: "tire_size", description: "2.1")
rear_shock = Part.new(name: "rear_shock", description: "Fox", needs_spare: false)
front_shock = Part.new(name: "front_shock", description: "Mainitou")

road_bike_parts = Parts.new([chain, road_tire, tape])
road_bike = Bicycle.new(size: "L", parts: road_bike_parts)

p road_bike.spares

#==========================================================================
# Change Parts to be an Enumerable, so that we can use select and each, and add a size method
require "forwardable"

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

road_bike_parts = Parts.new([chain, road_tire, tape])
moutain_bike_parts = Parts.new([chain, moutain_tire, front_shock, rear_shock])
road_bike = Bicycle.new(size: "L", parts: road_bike_parts)
moutain_bike = Bicycle.new(size: "L", parts: moutain_bike_parts)

p moutain_bike.spares.size
p moutain_bike.parts.size
p moutain_bike.parts + road_bike.parts

#==========================================================================
# Create a PartsFactory
module PartsFactory
  def self.build(config, part_class: Part, parts_class = Parts)
    parts_class.new(
      config.collect { |part_config| create_part(part_config) }
    )
  end

  def self.create_part(part_config)
    Part.new(
      name: part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true)
    )
  end
end

road_config = [
  ["chain", "11-speed"],
  ["tire_size", "23"],
  ["tape_color", "red"]
]
p PartsFactory.build(road_config)

#==========================================================================
# Remove Part class, use ostruct instead give us the final version
class Bicycle
  attr_reader :size, :parts

  def initialize(size:, parts:)
    @size = size
    @parts = parts
  end

  def spares
    parts.select { |part| part.needs_spare }
  end
end

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config:, parts_class: Parts)
    parts_class.new(config.collect { |part_config| create_part(part_config) })
  end

  def self.create_part(part_config)
    OpenStruct.new(name: part_config[0], description: part_config[1], needs_spare: part_config.fetch(2, true))
  end
end

road_config = [
  ['chain', '11-speed'],
  ['tire_size', '23'],
  ['tape_color', 'red']
]
road_bike = Bicycle.new(size: 'L', parts: PartsFactory.build(config: road_config))
p road_bike.spares

moutain_config = [
  ['chain', '11-speed'],
  ['tire_size', '2.1'],
  ['front_shock', 'Mainitou'],
  ['rear_shock', 'Fox', false]
]
moutain_bike = Bicycle.new(size: 'L', parts: PartsFactory.build(config: moutain_config))
p moutain_bike.spares
