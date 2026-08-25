abstract class Readable {
  void readBook();
  void displayBook();
}

class Book implements Readable {
  String bookname;
  String title;
  String author;

  Book(this.bookname, this.title, this.author);

  @override
  void readBook() {
    print("Reading $bookname by $author");
  }

  @override
  void displayBook() {
    print("Book Name: $bookname");
    print("Book Title: $title");
    print("Author: $author");
  }
}

void task6() {
  Book book1 = Book("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling");
  Book book2 = Book("The Hobbit", "The Hobbit", "J.R.R. Tolkien");
  Book book3 = Book("1984", "Nineteen Eighty-Four", "George Orwell");
  Book book4 = Book("The Alchemist", "The Alchemist", "Paulo Coelho");
  Book book5 = Book("Pride and Prejudice", "Pride and Prejudice", "Jane Austen");
  Book book6 = Book("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam");
  Book book7 = Book("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald");
  Book book8 = Book("Atomic Habits", "Atomic Habits", "James Clear");
  Book book9 = Book("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki");
  Book book10 = Book("The Psychology of Money", "The Psychology of Money", "Morgan Housel");

  book1.displayBook();
  book1.readBook();
  print("---------------");

  book2.displayBook();
  book2.readBook();
  print("---------------");

  book3.displayBook();
  book3.readBook();
  print("---------------");

  book4.displayBook();
  book4.readBook();
  print("---------------");

  book5.displayBook();
  book5.readBook();
  print("---------------");

  book6.displayBook();
  book6.readBook();
  print("---------------");

  book7.displayBook();
  book7.readBook();
  print("---------------");

  book8.displayBook();
  book8.readBook();
  print("---------------");

  book9.displayBook();
  book9.readBook();
  print("---------------");

  book10.displayBook();
  book10.readBook();
}
