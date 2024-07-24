# Query Test - just checking the state of the object
describe Car do
  it 'asks the engine for its status' do
    engine = double('engine', status: 'running')
    car = Car.new(engine)
    expect(car.engine_status).to eq('running')
  end
end

# Command Test - changing the state of the object
describe Car do
  it 'tells the engine to start' do
    engine = double('engine')
    car = Car.new(engine)
    expect(engine).to receive(:start)
    car.start
  end
end
