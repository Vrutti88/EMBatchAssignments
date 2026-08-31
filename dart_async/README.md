# Dart Asynchronous Programming, Null Safety & Mock API Application

**Assignment Title:** Dart Asynchronous Programming & Null Safety with Mock API Integration  
**Course/Batch:** Flutter Development – EMBatchAssignments  
**Submission Date:** August 31, 2026  

---

## 📌 Project Overview
This project demonstrates how to build a robust, production-ready Dart and Flutter application utilizing:
1. **Sound Null Safety**: Nullable types (`String?`), non-nullable assertions, and the null-coalescing operator (`??`).
2. **Asynchronous Programming**: `Future`, `async`, `await`, `Future.delayed`, and operation timeouts (`.timeout()`).
3. **Exception Handling**: Safe network simulation using `try`, `catch`, and `finally`.
4. **Interactive Flutter UI**: A clean UI displaying Loading, Success, Null, and Error states.

---

## 📂 Project Architecture & Files

```
dart_async/
├── lib/
│   ├── async_dart.dart    # Mock API service, business logic & console test runner
│   └── main.dart          # Flutter user interface & state management
├── test/
│   └── widget_test.dart   # Smoke tests for widget rendering
├── pubspec.yaml           # Dependencies and project metadata
├── README.md              # Project overview & documentation
└── ASSIGNMENT_REPORT.md   # Complete assignment evaluation report
```

---

## 🚀 How to Run the Project

### Option 1: Run as a Flutter App (Device / Emulator / Chrome)
```bash
flutter run
```

### Option 2: Run directly in the Dart Console
```bash
dart run lib/async_dart.dart
```

---

## 🧪 Test Scenarios & Expected Outputs

### 1. Success Case (`hasError: false, isNull: false`)
- **Behavior**: Waits 2 seconds, returns valid mock user data.
- **Output**:
  ```text
  Wait for 2 secs...
  Success: User Data: Name = John Doe, Role = Developer
  Finally block executed successfully
  ```

### 2. Null Response Case (`hasError: false, isNull: true`)
- **Behavior**: Waits 2 seconds, returns `null`, safely handled by `??` operator.
- **Output**:
  ```text
  Wait for 2 secs...
  Success: Warning: No user data found (Null).
  Finally block executed successfully
  ```

### 3. Error Case (`hasError: true, isNull: false`)
- **Behavior**: Waits 2 seconds, throws a network `Exception`, caught in `catch` block.
- **Output**:
  ```text
  Wait for 2 secs...
  Future code cannot be executed: Exception: Network error: Unable to fetch data
  Finally block executed successfully
  ```

---

## 📖 Key Concepts Demonstrated

- **Null Safety**:
  ```dart
  String? result = await fetchUserData(...);
  String finalMessage = result ?? "Warning: No user data found (Null).";
  ```
- **Async / Await with Timeout**:
  ```dart
  String? result = await fetchUserData(...)
      .timeout(const Duration(seconds: 5));
  ```
- **Try-Catch-Finally**:
  ```dart
  try {
    // async work
  } catch (e) {
    // handle error
  } finally {
    // guaranteed cleanup
  }
  ```

