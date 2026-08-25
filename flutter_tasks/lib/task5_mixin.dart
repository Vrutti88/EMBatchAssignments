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

mixin Borrowable {
  void borrowBook() {
    print("Book is borrowed");
  }

  void returnBook() {
    print("Book is returned");
  }
}

class LibraryBook extends Book with Borrowable {
  LibraryBook(String bookname, String title, String author)
      : super(bookname, title, author);
}

void task5() {
  LibraryBook book1 = LibraryBook("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling");
  LibraryBook book2 = LibraryBook("The Hobbit", "The Hobbit", "J.R.R. Tolkien");
  LibraryBook book3 = LibraryBook("1984", "Nineteen Eighty-Four", "George Orwell");
  LibraryBook book4 = LibraryBook("The Alchemist", "The Alchemist", "Paulo Coelho");
  LibraryBook book5 = LibraryBook("Pride and Prejudice", "Pride and Prejudice", "Jane Austen");
  LibraryBook book6 = LibraryBook("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam");
  LibraryBook book7 = LibraryBook("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald");
  LibraryBook book8 = LibraryBook("Atomic Habits", "Atomic Habits", "James Clear");
  LibraryBook book9 = LibraryBook("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki");
  LibraryBook book10 = LibraryBook("The Psychology of Money", "The Psychology of Money", "Morgan Housel");

  book1.displayBook();
  book1.borrowBook();
  book1.returnBook();
  print("---------------");

  book2.displayBook();
  book2.borrowBook();
  book2.returnBook();
  print("---------------");

  book3.displayBook();
  book3.borrowBook();
  book3.returnBook();
  print("---------------");

  book4.displayBook();
  book4.borrowBook();
  book4.returnBook();
  print("---------------");

  book5.displayBook();
  book5.borrowBook();
  book5.returnBook();
  print("---------------");

  book6.displayBook();
  book6.borrowBook();
  book6.returnBook();
  print("---------------");

  book7.displayBook();
  book7.borrowBook();
  book7.returnBook();
  print("---------------");

  book8.displayBook();
  book8.borrowBook();
  book8.returnBook();
  print("---------------");

  book9.displayBook();
  book9.borrowBook();
  book9.returnBook();
  print("---------------");

  book10.displayBook();
  book10.borrowBook();
  book10.returnBook();
}
