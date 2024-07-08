# Violation of LSP
class Bird:
    def fly(self):
        pass

class Ostrich(Bird):
    def fly(self):
        raise Exception("Ostriches can't fly")

# Following LSP
from abc import ABC, abstractmethod

class Bird(ABC):
    @abstractmethod
    def move(self):
        pass

class FlyingBird(Bird):
    def move(self):
        self.fly()

    def fly(self):
        pass

class Ostrich(Bird):
    def move(self):
        self.run()

    def run(self):
        pass
