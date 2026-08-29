# Dart & Flutter OOP Assignment Report

**Course:** Flutter & Dart Application Development  
**Topic:** Object-Oriented Programming (OOP) & Collections in Dart (Tasks 1 to 10)  
**Author:** Vrutti Patil  
**Repository:** [GitHub Repository](https://github.com/Vrutti88/EMBatchAssignments)  

---

## 1. Assignment Overview & Objectives

The primary objective of this assignment is to master the foundational and advanced concepts of Object-Oriented Programming (OOP) and Collections in Dart by developing a structured Book Management System across 10 progressive tasks.

Each task explores a specific programming concept using the consistent entity of a `Book`:
- **Task 1:** Classes and Objects
- **Task 2:** Parameterized Constructors
- **Task 3:** Instance and Parameterized Methods
- **Task 4:** Single Inheritance and Method Overriding
- **Task 5:** Mixins and Code Reusability
- **Task 6:** Abstract Classes and Interfaces
- **Task 7:** List Collections and Iteration
- **Task 8:** Map Collections and Key-Value Operations
- **Task 9:** Set Collections and Deduplication
- **Task 10:** Complete Library Management System
- **Main App:** Interactive Flutter UI with dynamic task switching and console execution

---

## 2. Detailed Task Breakdown & Implementation

### Task 1: Class & Object (`task1_class.dart`)
- **Concept:** Defining a blueprint using the `class` keyword with fields (`bookname`, `title`, `author`) and an instance method (`displayBook()`).
- **Implementation:** 10 individual `Book` objects were instantiated, their fields assigned and displayed.

### Task 2: Constructors (`task2_constructor.dart`)
- **Concept:** Replacing manual property assignment with concise positional constructors (`Book(this.bookname, this.title, this.author)`).
- **Implementation:** Initialized 10 books in a single statement per book.

### Task 3: Methods (`task3_methods.dart`)
- **Concept:** Encapsulating behaviors within methods: `openBook()`, `closeBook()` and `displayBook()`.
- **Implementation:** Executing state transitions and actions on book instances.

### Task 4: Inheritance (`task4_inheritance.dart`)
- **Concept:** Reusing code from a base class (`Book`) in a derived class (`EBook`) using `extends` and `super(...)`, while overriding `displayBook()` to show extra properties (`fileType`).
- **Implementation:** Demonstrating polymorphism where `EBook` is a specialized form of `Book`.

### Task 5: Mixins (`task5_mixin.dart`)
- **Concept:** Adding reusable behavior without multi-level inheritance using `mixin Borrowable` and the `with` keyword.
- **Implementation:** `LibraryBook extends Book with Borrowable` gains `borrowBook()` and `returnBook()` capabilities.

### Task 6: Interfaces (`task6_interface.dart`)
- **Concept:** Defining contracts using `abstract class Readable` and the `implements` keyword.
- **Implementation:** `class Book implements Readable` enforces concrete implementations of `readBook()` and `displayBook()`.

### Task 7: Lists (`task7_list.dart`)
- **Concept:** Managing indexed collections of objects with `List<Book>`.
- **Implementation:** Storing 10 books in an ordered list and iterating through them using loops and indexing.

### Task 8: Maps (`task8_map.dart`)
- **Concept:** Key-value pair storage using `Map<int, Book>`.
- **Implementation:** Mapping unique Book IDs (keys) to `Book` objects (values) and iterating with `forEach()`.

### Task 9: Sets (`task9_set.dart`)
- **Concept:** Managing unique collections using `Set<Book>`.
- **Implementation:** Demonstrating unordered, unique collections of books.

### Task 10: Library Management System (`task10_library.dart`)
- **Concept:** Combining OOP encapsulation and collection manipulation into a cohesive system.
- **Implementation:** `Library` class offering `addBook()`, `removeBook()`, `borrowBook()`, `returnBook()`, `searchBook()` and `displayBooks()`.

---

## 3. Flutter User Interface (`main.dart`)

The Flutter application provides an interactive dashboard:
1. **Dynamic Task Selector:** Top horizontal scrollable chip bar allowing switching between Tasks 1 through 10.
2. **On-Screen Visualization:** Displays clean, structured cards for all 10 books along with task-specific metadata (file types, borrow statuses, list indexes, map keys, etc.).
3. **Selective Execution:** When a task chip is selected, only that specific task function is executed in the console, preventing unnecessary overhead.

---

## 4. What I Learned (Detailed Learning & Reflection)

### 4.1 Understanding Dart OOP Architecture
Working through these 10 tasks provided a deep, practical understanding of Dart's object model:
- **Classes & Encapsulation:** I learned how classes act as clean models for real-world entities. Grouping data (`bookname`, `title`, `author`) with functions (`displayBook`, `openBook`) ensures modular, maintainable code.
- **Constructors:** Understanding Dart's generative constructors (`this.property`) showed me how Dart minimizes boilerplate code compared to languages like Java or C++.
- **Inheritance vs. Mixins vs. Interfaces:**
  - *Inheritance (`extends`)*: Ideal for "is-a" relationships (e.g., an `EBook` is a `Book`) where child classes inherit state and behavior.
  - *Mixins (`with`)*: Ideal for sharing functionality across unrelated classes without the diamond problem of multiple inheritance (e.g., adding `Borrowable` to books, laptops, or DVDs).
  - *Interfaces (`implements`)*: Ideal for defining strict API contracts where classes must define their own specific implementation of every method.

### 4.2 Mastering Dart Collections
- **Lists:** Crucial when order matters and duplicate elements are allowed. Great for sequential displays and indexed access.
- **Maps:** Highly efficient for lookups when each entity has a unique identifier (like Book ID or ISBN).
- **Sets:** Essential when uniqueness must be guaranteed without manual duplicate checking.

### 4.3 Problems Faced & Solutions

1. **Problem 1: Console Execution vs. Flutter App Lifecycle**
   - *Issue:* Initially, calling all `task1()` to `task10()` directly in `void main()` caused all 10 tasks to execute at once when launching the Flutter app, cluttering the debug console.
   - *Solution:* Refactored `main.dart` so that `void main()` only starts the widget tree with `runApp()`. Each task is now triggered selectively via an interactive task switcher (`runTask(taskNum)`).

2. **Problem 2: Blank Screen When Running Flutter**
   - *Issue:* When running the project as a Flutter application, only `print()` statements were executing in the console, leaving the mobile/emulator screen blank.
   - *Solution:* Built a complete Material 3 UI in `main.dart` with `ChoiceChip` filters and `ListView.builder` cards to visually render the book details directly on the device screen.

3. **Problem 3: Scope and Name Collisions across Files**
   - *Issue:* Because each task file defines its own `Book` class tailored to that lesson, importing all task files into `main.dart` caused potential name conflicts.
   - *Solution:* Used explicit Dart `show` directives (e.g., `import 'task1_class.dart' show task1;`) to only export the required runner functions into `main.dart`.

4. **Problem 4: Code Cleanliness and Formatting Guidelines**
   - *Issue:* Ensuring all code follows strict assignment guidelines without leftover comments, redundant parameters, or unnecessary complex dependencies.
   - *Solution:* Systematically cleaned all 10 task files and `main.dart`, verifying zero comments, uniform variable names, and clear outputs.

---
