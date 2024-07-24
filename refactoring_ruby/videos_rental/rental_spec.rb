require 'rspec'
require_relative 'video_rental'
require 'pry'

RSpec.describe 'Customer' do
  before do
    movie1 = Movie.new("The Matrix", RegularPrice.new)
    movie2 = Movie.new("Avengers: Endgame", NewReleasePrice.new)
    movie3 = Movie.new("Frozen", ChildrensPrice.new)

    # Create rentals
    rental1 = Rental.new(movie1, 3) # Rented for 3 days
    rental2 = Rental.new(movie2, 2) # Rented for 2 days
    rental3 = Rental.new(movie3, 4) # Rented for 4 days

    # Create a customer
    @customer = Customer.new("John Doe")

    # Add rentals to the customer
    @customer.add_rental(rental1)
    @customer.add_rental(rental2)
    @customer.add_rental(rental3)
  end

  describe '#statement' do
    it 'should return the statement' do
      expected_output = <<~TEXT.chomp
        Rental Record for John Doe
        \tThe Matrix\t3.5
        \tAvengers: Endgame\t6
        \tFrozen\t3.0
        Amount owed is 12.5
        You earned 4 frequent renter points
      TEXT

      expect(@customer.statement).to eq(expected_output)
    end
  end
end
