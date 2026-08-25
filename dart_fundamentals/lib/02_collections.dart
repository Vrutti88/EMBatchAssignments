void main() {
  List<int> numbers = [10, 20, 30];
  numbers.add(40);
  numbers.remove(10);
  print('Second item in list: ${numbers[1]}');

  Set<String> fruits = {"apple", "banana", "apple"};
  print('Set elements (unique): $fruits');

  Map<String, dynamic> student = {'name': 'Alex', 'grade': 'A'};
  student['age'] = 20;
  print('Student Map: $student');

  int parsedInt = int.parse("123");
  print('Converted "123" to int: $parsedInt');

  double doubleValue = 45.67;
  String formattedDouble = doubleValue.toStringAsFixed(1);
  print('Converted 45.67 with 1 decimal place: $formattedDouble');
}
