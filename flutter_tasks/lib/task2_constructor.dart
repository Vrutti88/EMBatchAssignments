class Book{
  String bookname;
  String title;
  String author;

  Book(this.bookname,this.title,this.author);

  void displayBook(){
    print("Book Name:: $bookname");
    print("Book Title: $title");
    print("Author: $author");
  }
}

void task2() {

  Book book1 = Book(
  "Harry Potter",
  "Harry Potter and the Philosopher's Stone",
  "J.K. Rowling"
  );

  Book book2 = Book(
  "The Hobbit",
  "The Hobbit",
  "J.R.R. Tolkien");

  Book book3 = Book(
  "1984",
  "Nineteen Eighty-Four",
  "George Orwell");

  Book book4 = Book(
  "The Alchemist",
  "The Alchemist",
  "Paulo Coelho");

  Book book5 = Book(
  "Pride and Prejudice",
  "Pride and Prejudice",
  "Jane Austen");

  Book book6 = Book(
  "Wings of Fire",
  "Wings of Fire",
  "A.P.J. Abdul Kalam");

  Book book7 = Book(
  "The Great Gatsby",
  "The Great Gatsby",
  "F. Scott Fitzgerald");

  Book book8 = Book(
  "Atomic Habits",
  "Atomic Habits",
  "James Clear");

  Book book9 = Book(
  "Rich Dad Poor Dad",
  "Rich Dad Poor Dad",
  "Robert Kiyosaki");

  Book book10 = Book("The Psychology of Money",
  "The Psychology of Money",
  "Morgan Housel");

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