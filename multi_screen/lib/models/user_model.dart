class UserModel {
  final String name;
  final String email;
  final String phone;
  final DateTime registrationDate;

  const UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.registrationDate,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }
}
