class Vehicle:
    def __init__(self, make, model, year):
        self.make = make           # Public attribute
        self.model = model         # Public attribute
        self.year = year           # Public attribute
        self._mileage = 0          # Protected attribute

    def drive(self, distance):
        if distance > 0:
            self._mileage += distance
            print(f"Vehicle driven for {distance} miles. New mileage: {self._mileage} miles")
        else:
            print("Invalid distance")

    def get_mileage(self):
        return self._mileage

    def service(self):
        print("Vehicle is being serviced")
        self.__service_engine()      # Call to private method

    # Private method
    def __service_engine(self):
        print("Engine serviced")

# Subclass Car
class Car(Vehicle):
    def __init__(self, make, model, year, num_doors):
        super().__init__(make, model, year)
        self.num_doors = num_doors  # Public attribute

    def open_doors(self):
        print(f"Opening {self.num_doors} doors")

# Subclass Bike
class Bike(Vehicle):
    def __init__(self, make, model, year, type_bike):
        super().__init__(make, model, year)
        self.type_bike = type_bike  # Public attribute

    def ring_bell(self):
        print("Ring ring!")

# Usage
car = Car("Toyota", "Camry", 2020, 4)
bike = Bike("Trek", "Marlin 7", 2021, "Mountain Bike")

# Access public attributes and methods
print(f"Car: {car.make} {car.model} {car.year}, Doors: {car.num_doors}")
print(f"Bike: {bike.make} {bike.model} {bike.year}, Type: {bike.type_bike}")

# Drive the car and bike
car.drive(50)
bike.drive(15)

# Access protected attribute via public method
print(f"Car mileage: {car.get_mileage()} miles")
print(f"Bike mileage: {bike.get_mileage()} miles")

# Service the car and bike
car.service()
bike.service()

# Specific methods for car and bike
car.open_doors()
bike.ring_bell()

# Trying to access protected and private attributes/methods from outside the class
# print(car._mileage)          # Not recommended, but possible
# car.__service_engine()       # This will raise an AttributeError
