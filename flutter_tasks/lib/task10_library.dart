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

class Library {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
  }

  void displayBooks() {
    for (int i = 0; i < books.length; i++) {
      books[i].displayBook();
      if (i < books.length - 1) {
        print("---------------");
      }
    }
  }
}

void task10() {
  Library library = Library();

  library.addBook(Book("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling"));
  library.addBook(Book("The Hobbit", "The Hobbit", "J.R.R. Tolkien"));
  library.addBook(Book("1984", "Nineteen Eighty-Four", "George Orwell"));
  library.addBook(Book("The Alchemist", "The Alchemist", "Paulo Coelho"));
  library.addBook(Book("Pride and Prejudice", "Pride and Prejudice", "Jane Austen"));
  library.addBook(Book("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam"));
  library.addBook(Book("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald"));
  library.addBook(Book("Atomic Habits", "Atomic Habits", "James Clear"));
  library.addBook(Book("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki"));
  library.addBook(Book("The Psychology of Money", "The Psychology of Money", "Morgan Housel"));

  library.displayBooks();
}
