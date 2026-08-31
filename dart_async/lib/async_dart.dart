// 1. Mock API function using Future and async/await
Future<String?> fetchUserData({bool hasError = false, bool isNull = false}) async {
  print("Wait for 2 secs...");
  await Future.delayed(const Duration(seconds: 2));

  // Error case: throw an exception
  if (hasError) {
    throw Exception("Network error: Unable to fetch data");
  }

  // Null case: return null
  if (isNull) {
    return null;
  }

  // Success case: return valid data string
  return "User Data: Name = John Doe, Role = Developer";
}

// 2. Function to handle null safety and try-catch-finally
Future<String> getUserData({bool hasError = false, bool isNull = false}) async {
  try {
    // Await the async function with a timeout
    String? result = await fetchUserData(hasError: hasError, isNull: isNull)
        .timeout(const Duration(seconds: 5));

    // Null Safety: handle null with null-coalescing operator '??'
    String finalMessage = result ?? "Warning: No user data found (Null).";
    print("Success: $finalMessage");
    return finalMessage;
  } catch (e) {
    // Error handling
    String errorMessage = "Future code cannot be executed: $e";
    print(errorMessage);
    return errorMessage;
  } finally {
    // Finally block always executes
    print("Finally block executed successfully");
  }
}

// 3. Main function to test in console
void main() async {
  print("=== 1. Test Success Case ===");
  await getUserData(hasError: false, isNull: false);

  print("\n=== 2. Test Null Case ===");
  await getUserData(hasError: false, isNull: true);

  print("\n=== 3. Test Error Case ===");
  await getUserData(hasError: true, isNull: false);
}