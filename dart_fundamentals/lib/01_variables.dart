void main() {
  var cityName = "Tokyo";
  print('City Name: $cityName');
  print('Runtime Type: ${cityName.runtimeType}');

  Object objVal = 42;
  print('objVal: $objVal');

  dynamic dynVal = "Hello";
  dynVal = 100;
  try {
    dynVal.toUpperCase();
  } catch (e) {
    print('Caught expected runtime error on dynamic: $e');
  }

  final DateTime currentDateTime = DateTime.now();
  print('Final DateTime: $currentDateTime');

  const double pi = 3.14159;
  print('Const pi: $pi');

  int age = 25;
  double temperature = 98.6;
  double divisionResult = temperature / age;
  print('temperature / age = $divisionResult');

  String firstName = "Ada";
  String lastName = "Lovelace";
  String fullName = "$firstName $lastName";
  String userInfo = "User: $fullName (Length: ${fullName.length})";
  print(userInfo);

  bool isLoggedIn = false;
  isLoggedIn = !isLoggedIn;
  print('isLoggedIn (toggled): $isLoggedIn');

  String emojiStr = '🎯';
  print('Emoji String: $emojiStr');
  print('Code Units: ${emojiStr.codeUnits}');
  print('Runes: ${emojiStr.runes.toList()}');
}
