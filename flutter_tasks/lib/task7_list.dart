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

void task7() {
  List<Book> books = [
    Book("Harry Potter", "Harry Potter and the Philosopher's Stone", "J.K. Rowling"),
    Book("The Hobbit", "The Hobbit", "J.R.R. Tolkien"),
    Book("1984", "Nineteen Eighty-Four", "George Orwell"),
    Book("The Alchemist", "The Alchemist", "Paulo Coelho"),
    Book("Pride and Prejudice", "Pride and Prejudice", "Jane Austen"),
    Book("Wings of Fire", "Wings of Fire", "A.P.J. Abdul Kalam"),
    Book("The Great Gatsby", "The Great Gatsby", "F. Scott Fitzgerald"),
    Book("Atomic Habits", "Atomic Habits", "James Clear"),
    Book("Rich Dad Poor Dad", "Rich Dad Poor Dad", "Robert Kiyosaki"),
    Book("The Psychology of Money", "The Psychology of Money", "Morgan Housel"),
  ];

  for (int i = 0; i < books.length; i++) {
    books[i].displayBook();
    if (i < books.length - 1) {
      print("---------------");
    }
  }
}
