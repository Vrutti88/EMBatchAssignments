import 'package:flutter/material.dart';
import 'task1_class.dart' show task1;
import 'task2_constructor.dart' show task2;
import 'task3_methods.dart' show task3;
import 'task4_inheritance.dart' show task4;
import 'task5_mixin.dart' show task5;
import 'task6_interface.dart' show task6;
import 'task7_list.dart' show task7;
import 'task8_map.dart' show task8;
import 'task9_set.dart' show task9;
import 'task10_library.dart' show task10;

void main() {
  task1();
  task2();
  task3();
  task4();
  task5();
  task6();
  task7();
  task8();
  task9();
  task10();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTask = 1;

  final List<Map<String, String>> books = const [
    {"name": "Harry Potter", "title": "Harry Potter and the Philosopher's Stone", "author": "J.K. Rowling", "extra": "PDF"},
    {"name": "The Hobbit", "title": "The Hobbit", "author": "J.R.R. Tolkien", "extra": "EPUB"},
    {"name": "1984", "title": "Nineteen Eighty-Four", "author": "George Orwell", "extra": "PDF"},
    {"name": "The Alchemist", "title": "The Alchemist", "author": "Paulo Coelho", "extra": "EPUB"},
    {"name": "Pride and Prejudice", "title": "Pride and Prejudice", "author": "Jane Austen", "extra": "PDF"},
    {"name": "Wings of Fire", "title": "Wings of Fire", "author": "A.P.J. Abdul Kalam", "extra": "PDF"},
    {"name": "The Great Gatsby", "title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "extra": "EPUB"},
    {"name": "Atomic Habits", "title": "Atomic Habits", "author": "James Clear", "extra": "PDF"},
    {"name": "Rich Dad Poor Dad", "title": "Rich Dad Poor Dad", "author": "Robert Kiyosaki", "extra": "EPUB"},
    {"name": "The Psychology of Money", "title": "The Psychology of Money", "author": "Morgan Housel", "extra": "PDF"},
  ];

  String getTaskName(int index) {
    switch (index) {
      case 1:
        return "Task 1: Class";
      case 2:
        return "Task 2: Constructor";
      case 3:
        return "Task 3: Methods";
      case 4:
        return "Task 4: Inheritance";
      case 5:
        return "Task 5: Mixin";
      case 6:
        return "Task 6: Interface";
      case 7:
        return "Task 7: List";
      case 8:
        return "Task 8: Map";
      case 9:
        return "Task 9: Set";
      case 10:
        return "Task 10: Library";
      default:
        return "Task $index";
    }
  }

  String getExtraInfo(int taskIndex, Map<String, String> book, int itemIndex) {
    switch (taskIndex) {
      case 3:
        return "${book['name']} of author ${book['author']} is opened\n${book['name']} of author ${book['author']} is closed";
      case 4:
        return "File Type: ${book['extra']}";
      case 5:
        return "Borrow Status: Book is borrowed\nReturn Status: Book is returned";
      case 6:
        return "Reading ${book['name']} by ${book['author']}";
      case 7:
        return "List Index: $itemIndex";
      case 8:
        return "Map Key / Book ID: ${itemIndex + 1}";
      case 9:
        return "Set Element: ${itemIndex + 1}";
      case 10:
        return "Library Catalog Item #${itemIndex + 1}";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTaskName(selectedTask)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: 10,
              itemBuilder: (context, index) {
                int taskNum = index + 1;
                bool isSelected = selectedTask == taskNum;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text("Task $taskNum"),
                    selected: isSelected,
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          selectedTask = taskNum;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                String extra = getExtraInfo(selectedTask, book, index);

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Book ${index + 1}: ${book['name']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Title: ${book['title']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Author: ${book['author']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        if (extra.isNotEmpty) ...[
                          const Divider(height: 16),
                          Text(
                            extra,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
