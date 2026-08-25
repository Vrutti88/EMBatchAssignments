class Student {
  String name = '';
  int score = 0;
  void display() => print('$name scored $score');
}

void main() {
  int modResult = 17 % 4;
  int intDivResult = 17 ~/ 4;
  print('Modulus (17 % 4): $modResult');
  print('Integer division (17 ~/ 4): $intDivResult');

  bool compResult = 10 >= 10;
  print('Comparison (10 >= 10): $compResult');

  dynamic val = "Dart Language";
  if (val is String) {
    print('val is String: true');
  }

  String castedString = val as String;
  print('String length: ${castedString.length}');

  bool hasTicket = true;
  bool hasId = false;
  String status = (hasTicket && hasId) ? "Allowed" : "Denied";
  print('Status: $status');

  Student()
    ..name = 'John'
    ..score = 95
    ..display();

  Student? nullableStudent;
  nullableStudent
    ?..name = 'Jane'
    ..score = 90
    ..display();
  print('Null-aware cascade (?..) evaluated safely on null reference.');
}
