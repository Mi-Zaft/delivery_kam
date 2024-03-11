class User {
  static User? _instance;
  String? name = '';

  User._();

  factory User() => _instance ??= User._();
}