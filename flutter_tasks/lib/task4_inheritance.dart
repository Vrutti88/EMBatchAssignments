class Book {
  String bookname;
  String title;
  String author;

  Book(this.bookname, this.title, this.author);

  void displayBook() {
    print("Book Name: $bookname");
    print("Book Title: $title");
    print("Author: $author");
  }
}

class EBook extends Book {
  String fileType;

  EBook(String bookname, String title, String author, this.fileType)
      : super(bookname, title, author);

  @override
  void displayBook() {
    super.displayBook();
    print("File Type: $fileType");
  }
}

void task4() {
  EBook book1 = EBook("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling", "PDF");
  EBook book2 = EBook("The Hobbit", "The Hobbit", "J.R.R. Tolkien", "EPUB");
  EBook book3 = EBook("1984", "Nineteen Eighty-Four", "George Orwell", "PDF");
  EBook book4 = EBook("The Alchemist", "The Alchemist", "Paulo Coelho", "EPUB");
  EBook book5 = EBook("Pride and Prejudice", "Pride and Prejudice", "Jane Austen", "PDF");
  EBook book6 = EBook("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam", "PDF");
  EBook book7 = EBook("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald", "EPUB");
  EBook book8 = EBook("Atomic Habits", "Atomic Habits", "James Clear", "PDF");
  EBook book9 = EBook("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki", "EPUB");
  EBook book10 = EBook("The Psychology of Money", "The Psychology of Money", "Morgan Housel", "PDF");

  book1.displayBook();
  print("---------------");
  book2.displayBook();
  print("---------------");
  book3.displayBook();
  print("---------------");
  book4.displayBook();
  print("---------------");
  book5.displayBook();
  print("---------------");
  book6.displayBook();
  print("---------------");
  book7.displayBook();
  print("---------------");
  book8.displayBook();
  print("---------------");
  book9.displayBook();
  print("---------------");
  book10.displayBook();
}
