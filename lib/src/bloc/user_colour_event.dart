import 'package:flutter/material.dart';

abstract class UserColourEvent {
  const UserColourEvent();
}

/// Событие для добавления новых пользователей и цветов
class UserColourFetchedEvent extends UserColourEvent {
  const UserColourFetchedEvent();
}

/// Событие для поиска пользователей
class UserColourFindEvent extends UserColourEvent {
  final String name;
  final int totalUserNumber;
  const UserColourFindEvent(
      {@required this.totalUserNumber, @required this.name});
}

/// Событие очищения поискового запроса
class UserColourClearEvent extends UserColourEvent {}
