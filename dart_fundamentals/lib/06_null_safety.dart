class UserProfile {
  late String bio;

  void initBio() {
    bio = "Developer from NYC";
  }
}

Never throwFatalError(String msg) {
  throw Exception("Fatal Error: $msg");
}

void main() {
  UserProfile profile = UserProfile();
  profile.initBio();
  print('UserProfile bio (late initialized): ${profile.bio}');

  int nonNullable = 10;
  int? nullableVal = null;
  print('nonNullable: $nonNullable, nullableVal: $nullableVal');

  int result = nullableVal ?? 0;
  print('result (with ?? fallback): $result');

  nullableVal ??= 5;
  print('nullableVal (after ??=): $nullableVal');

  String? text;
  print('Null-aware access (text?.length): ${text?.length}');

  text = "Dart";
  print('Bang operator (text!.length): ${text!.length}');

  Object data = "Smart Cast";
  if (data is String) {
    print('Type promoted uppercase: ${data.toUpperCase()}');
  }
}
