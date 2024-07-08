# Violation of DIP
class BackendDeveloper:
    def develop(self):
        self.write_java()

    def write_java(self):
        pass

class FrontendDeveloper:
    def develop(self):
        self.write_javascript()

    def write_javascript(self):
        pass

class Project:
    def __init__(self):
        self.backend = BackendDeveloper()
        self.frontend = FrontendDeveloper()

    def develop(self):
        self.backend.develop()
        self.frontend.develop()

# Following DIP
from abc import ABC, abstractmethod

class Developer(ABC):
    @abstractmethod
    def develop(self):
        pass

class BackendDeveloper(Developer):
    def develop(self):
        self.write_java()

    def write_java(self):
        pass

class FrontendDeveloper(Developer):
    def develop(self):
        self.write_javascript()

    def write_javascript(self):
        pass

class Project:
    def __init__(self, developers: list[Developer]):
        self.developers = developers

    def develop(self):
        for developer in self.developers:
            developer.develop()

backend = BackendDeveloper()
frontend = FrontendDeveloper()
project = Project([backend, frontend])
