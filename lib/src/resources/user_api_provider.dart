import 'dart:async';
import 'package:flutter_test_task/src/models/user_list_model.dart';
import 'package:flutter_test_task/src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApiProvider {
  /// Get запрос пользователей
  Future<UserListModel> fetchUserList({int pageNumber}) async {
    final _url = "https://reqres.in/api/users?page=$pageNumber";

    final response = await http.get(_url, headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
    });
    return (response.statusCode == 200)
        ? UserListModel.fromJson(jsonDecode(response.body))
        : throw Exception('Ошибка ${response.statusCode}');
  }

  /// Get запрос всех пользователей и поиск по имени
  Future<List<User>> getUsersByName({int total, String name}) async {
    final _url = "https://reqres.in/api/users?per_page=$total";
    final response = await http.get(_url, headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
    });
    return (response.statusCode == 200)
        ? UserListModel.fromJson(jsonDecode(response.body))
            .data
            .where((i) =>
                i.firstName.toLowerCase().startsWith(name) ||
                i.lastName.toLowerCase().startsWith(name) ||
                (i.firstName + i.lastName).toLowerCase().startsWith(name))
            .toList()
        : [];
  }
}
