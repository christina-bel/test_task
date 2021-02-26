import 'package:flutter_test_task/src/models/user_model.dart';

/// Класс списка пользователей
class UserListModel {
  int _page;
  int _perPage;
  int _total;
  int _totalPages;

  List<User> _data = [];

  UserListModel.fromJson(Map<String, dynamic> json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    for (int i = 0; i < json['data'].length; i++) {
      User user = User(json['data'][i]);
      _data.add(user);
    }
  }

  ///  Геттеры приватных свойств списка пользователей
  List<User> get data => _data;

  int get totalPages => _totalPages;

  int get totalResults => _total;

  int get perPage => _perPage;

  int get page => _page;

  bool get isNotEmpy => _data.isNotEmpty;
}
