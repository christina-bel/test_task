import 'package:flutter/foundation.dart';
import 'package:flutter_test_task/src/models/colour_model.dart';
import 'package:flutter_test_task/src/models/user_model.dart';

abstract class UserColourState {
  const UserColourState();
}

/// сообщает UI о необходимости инидикатора загрузки, пока грузится исходная страница пользователей
class UserColourInitialState extends UserColourState {
  const UserColourInitialState();
}

/// сообщает UI об ошибке при загрузке пользователей
class UserColourFailureState extends UserColourState {
  final String error;

  const UserColourFailureState({
    @required this.error,
  });
}

/// сообщает UI о загрузке пользователей
class UserColourLoadingUsersState extends UserColourState {
  const UserColourLoadingUsersState();
}

/// сообщает UI о загрузке пользователей при поиске по имени
class UserColourLoadingByNameState extends UserColourState {
  const UserColourLoadingByNameState();
}

/// сообщает UI об успешной загрузке пользователей
class UserColourSuccessState extends UserColourState {
  final List<User> users;
  final List<Colour> colours;
  final int total;

  const UserColourSuccessState({
    @required this.users,
    @required this.colours,
    this.total,
  });
}

/// сообщает UI об успешном поиске пользователей
class UserColourFindState extends UserColourState {
  final List<User> users;
  const UserColourFindState({
    @required this.users,
  });
}
