# Using Inheritance
class Document:
    def print(self):
        raise NotImplementedError

    def save(self):
        raise NotImplementedError

    def share(self):
        raise NotImplementedError

class PDFDocument(Document):
    def print(self):
        print("Printing PDF")

    def save(self):
        print("Saving PDF")

    def share(self):
        print("Sharing PDF")

class WordDocument(Document):
    def print(self):
        print("Printing Word Document")

    def save(self):
        print("Saving Word Document")

    def share(self):
        print("Sharing Word Document")

class ExcelDocument(Document):
    def print(self):
        print("Printing Excel Document")

    def save(self):
        print("Saving Excel Document")

    def share(self):
        print("Sharing Excel Document")

# Using Composition
class PrintBehavior:
    def print(self):
        raise NotImplementedError

class PDFPrintBehavior(PrintBehavior):
    def print(self):
        print("Printing PDF")

class WordPrintBehavior(PrintBehavior):
    def print(self):
        print("Printing Word Document")

class ExcelPrintBehavior(PrintBehavior):
    def print(self):
        print("Printing Excel Document")

class SaveBehavior:
    def save(self):
        raise NotImplementedError

class PDFSaveBehavior(SaveBehavior):
    def save(self):
        print("Saving PDF")

class WordSaveBehavior(SaveBehavior):
    def save(self):
        print("Saving Word Document")

class ExcelSaveBehavior(SaveBehavior):
    def save(self):
        print("Saving Excel Document")

class ShareBehavior:
    def share(self):
        raise NotImplementedError

class PDFShareBehavior(ShareBehavior):
    def share(self):
        print("Sharing PDF")

class WordShareBehavior(ShareBehavior):
    def share(self):
        print("Sharing Word Document")

class ExcelShareBehavior(ShareBehavior):
    def share(self):
        print("Sharing Excel Document")

class Document:
    def __init__(self, print_behavior, save_behavior, share_behavior):
        self.print_behavior = print_behavior
        self.save_behavior = save_behavior
        self.share_behavior = share_behavior

    def print(self):
        self.print_behavior.print()

    def save(self):
        self.save_behavior.save()

    def share(self):
        self.share_behavior.share()

# Example usage:
pdf_document = Document(PDFPrintBehavior(), PDFSaveBehavior(), PDFShareBehavior())
pdf_document.print()  # Printing PDF
pdf_document.save()   # Saving PDF
pdf_document.share()  # Sharing PDF

word_document = Document(WordPrintBehavior(), WordSaveBehavior(), WordShareBehavior())
word_document.print()  # Printing Word Document
word_document.save()   # Saving Word Document
word_document.share()  # Sharing Word Document


