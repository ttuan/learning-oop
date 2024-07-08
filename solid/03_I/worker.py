# Violation of ISP
class Worker:
    def work(self):
        pass

    def eat(self):
        pass

class HumanWorker(Worker):
    def work(self):
        # working
        pass

    def eat(self):
        # eating
        pass

class RobotWorker(Worker):
    def work(self):
        # working
        pass

    def eat(self):
        # do nothing
        pass

# Following ISP
class Workable:
    def work(self):
        pass

class Eatable:
    def eat(self):
        pass

class HumanWorker(Workable, Eatable):
    def work(self):
        # working
        pass

    def eat(self):
        # eating
        pass

class RobotWorker(Workable):
    def work(self):
        # working
        pass
