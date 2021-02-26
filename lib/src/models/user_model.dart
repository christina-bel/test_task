/// Класс пользователя
class User {
  int _id;
  String _email, _firstName, _lastName, _avatar;

  User(Map<String, dynamic> json) {
    _id = json['id'] ?? 0;
    _email = json['email'] ?? '';
    _firstName = json['first_name'] ?? '';
    _lastName = json['last_name'] ?? '';
    _avatar = json['avatar'] ?? '';
  }

  /// Геттеры приватных свойств пользователя
  String get avatar => _avatar;

  String get lastName => _lastName;

  String get firstName => _firstName;

  String get email => _email;

  int get id => _id;
}
