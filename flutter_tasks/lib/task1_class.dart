class Book{
  String bookname="";
  String title="";
  String author="";

  void displayBook(){
    print("Book Name:: $bookname");
    print("Book Title: $title");
    print("Author: $author");
  }
}

void task1() {

  Book book1 = Book();
  book1.bookname = "Harry Potter";
  book1.title = "Harry Potter and the Philosopher's Stone";
  book1.author = "J.K. Rowling";
  book1.displayBook();

  Book book2 = Book();
  book2.bookname = "The Hobbit";
  book2.title = "The Hobbit";
  book2.author = "J.R.R. Tolkien";
  book2.displayBook();

  Book book3 = Book();
  book3.bookname = "1984";
  book3.title = "Nineteen Eighty-Four";
  book3.author = "George Orwell";
  book3.displayBook();

  Book book4 = Book();
  book4.bookname = "The Alchemist";
  book4.title = "The Alchemist";
  book4.author = "Paulo Coelho";
  book4.displayBook();

  Book book5 = Book();
  book5.bookname = "Pride and Prejudice";
  book5.title = "Pride and Prejudice";
  book5.author = "Jane Austen";
  book5.displayBook();

  Book book6 = Book();
  book6.bookname = "Wings of Fire";
  book6.title = "Wings of Fire";
  book6.author = "A.P.J. Abdul Kalam";
  book6.displayBook();

  Book book7 = Book();
  book7.bookname = "The Great Gatsby";
  book7.title = "The Great Gatsby";
  book7.author = "F. Scott Fitzgerald";
  book7.displayBook();

  Book book8 = Book();
  book8.bookname = "Atomic Habits";
  book8.title = "Atomic Habits";
  book8.author = "James Clear";
  book8.displayBook();

  Book book9 = Book();
  book9.bookname = "Rich Dad Poor Dad";
  book9.title = "Rich Dad Poor Dad";
  book9.author = "Robert Kiyosaki";
  book9.displayBook();

  Book book10 = Book();
  book10.bookname = "The Psychology of Money";
  book10.title = "The Psychology of Money";
  book10.author = "Morgan Housel";
  book10.displayBook();
}