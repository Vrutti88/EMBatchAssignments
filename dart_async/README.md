# Null-Safe Async Fetcher

---

## 📌 Project Overview
This project demonstrates how to build a robust, production-ready Dart and Flutter application utilizing:
1. **Sound Null Safety**: Nullable types (`String?`), non-nullable assertions, and the null-coalescing operator (`??`).
2. **Asynchronous Programming**: `Future`, `async`, `await`, `Future.delayed`, and operation timeouts (`.timeout()`).
3. **Exception Handling**: Safe network simulation using `try`, `catch`, and `finally`.
4. **Interactive Flutter UI**: A clean UI displaying Loading, Success, Null, and Error states.

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

