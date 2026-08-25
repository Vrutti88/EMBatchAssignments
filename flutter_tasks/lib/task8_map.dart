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

void task8() {
  Map<int, Book> books = {
    1: Book("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling"),
    2: Book("The Hobbit", "The Hobbit", "J.R.R. Tolkien"),
    3: Book("1984", "Nineteen Eighty-Four", "George Orwell"),
    4: Book("The Alchemist", "The Alchemist", "Paulo Coelho"),
    5: Book("Pride and Prejudice", "Pride and Prejudice", "Jane Austen"),
    6: Book("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam"),
    7: Book("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald"),
    8: Book("Atomic Habits", "Atomic Habits", "James Clear"),
    9: Book("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki"),
    10: Book("The Psychology of Money", "The Psychology of Money", "Morgan Housel"),
  };

  books.forEach((key, book) {
    print("Book ID: $key");
    book.displayBook();
    if (key < books.length) {
      print("---------------");
    }
  });
}
