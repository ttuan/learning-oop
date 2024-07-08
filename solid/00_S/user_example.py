# Violation of SRP
class User:
    def __init__(self, name, email):
        self.name = name
        self.email = email

    def save_to_database(self):
        # code to save user to the database
        pass

    def send_email(self, message):
        # code to send email
        pass


# Following SRP
class User:
    def __init__(self, name, email):
        self.name = name
        self.email = email

class UserRepository:
    def save_to_database(self, user):
        # code to save user to the database
        pass

class EmailService:
    def send_email(self, user, message):
        # code to send email
        pass
