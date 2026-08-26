class Book {
  String bookname;
  String title;
  String author;
  bool isAvailable;

  Book(this.bookname, this.title, this.author, {this.isAvailable = true});

  void displayBook() {
    print("Book Name: $bookname");
    print("Book Title: $title");
    print("Author: $author");
    print("Status: ${isAvailable ? 'Available' : 'Borrowed'}");
  }
}

class Library {
  List<Book> books = [];

  void addBook(Book book) {
    books.add(book);
    print("Added: ${book.bookname}");
  }

  void removeBook(String bookname) {
    books.removeWhere((b) => b.bookname.toLowerCase() == bookname.toLowerCase());
    print("Removed: $bookname");
  }

  void borrowBook(String bookname) {
    for (var book in books) {
      if (book.bookname.toLowerCase() == bookname.toLowerCase()) {
        if (book.isAvailable) {
          book.isAvailable = false;
          print("$bookname has been borrowed successfully.");
        } else {
          print("$bookname is already borrowed.");
        }
        return;
      }
    }
    print("$bookname not found in library.");
  }

  void returnBook(String bookname) {
    for (var book in books) {
      if (book.bookname.toLowerCase() == bookname.toLowerCase()) {
        if (!book.isAvailable) {
          book.isAvailable = true;
          print("$bookname has been returned successfully.");
        } else {
          print("$bookname was not borrowed.");
        }
        return;
      }
    }
    print("$bookname not found in library.");
  }

  void searchBook(String query) {
    print("--- Search Results for '$query' ---");
    var results = books.where((b) =>
        b.bookname.toLowerCase().contains(query.toLowerCase()) ||
        b.author.toLowerCase().contains(query.toLowerCase()));

    if (results.isEmpty) {
      print("No books found matching '$query'.");
    } else {
      for (var book in results) {
        book.displayBook();
        print("---------------");
      }
    }
  }

  void displayBooks() {
    print("--- Library Books (${books.length} Total) ---");
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

  print("\n--- Displaying All Books ---");
  library.displayBooks();

  print("\n--- Borrowing a Book ---");
  library.borrowBook("Harry Potter");

  print("\n--- Searching for a Book ---");
  library.searchBook("George Orwell");

  print("\n--- Returning a Book ---");
  library.returnBook("Harry Potter");

  print("\n--- Removing a Book ---");
  library.removeBook("1984");
}
