import 'dart:async';
import 'package:flutter_test_task/src/models/user_list_model.dart';
import 'package:flutter_test_task/src/models/user_model.dart';
import 'package:flutter_test_task/src/resources/user_api_provider.dart';

class UserRepository {
  static final UserRepository _repository = UserRepository._();

  UserRepository._();

  factory UserRepository() {
    return _repository;
  }

  final _userApiProvider = UserApiProvider();

  Future<UserListModel> fetchUsers({int pageNumber}) =>
      _userApiProvider.fetchUserList(pageNumber: pageNumber);

  Future<List<User>> getUsersByName({int total, String name}) =>
      _userApiProvider.getUsersByName(total: total, name: name);
}
