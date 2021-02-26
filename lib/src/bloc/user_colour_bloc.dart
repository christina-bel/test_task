import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/src/bloc/user_colour_event.dart';
import 'package:flutter_test_task/src/bloc/user_colour_state.dart';
import 'package:flutter_test_task/src/resources/colour_repository.dart';
import 'package:flutter_test_task/src/resources/user_repository.dart';

class UserColourBloc extends Bloc<UserColourEvent, UserColourState> {
  final UserRepository userRepository;
  final ColourRepository colourRepository;
  int pageNumber = 1;

  /// Подгрузка пользователей
  bool isFetching = false;

  UserColourBloc({
    @required this.userRepository,
    @required this.colourRepository,
  }) : super(UserColourInitialState());

  @override
  Stream<UserColourState> mapEventToState(UserColourEvent event) async* {
    try {
      if (event is UserColourFetchedEvent) {
        yield UserColourLoadingUsersState();
        final userResponse =
            await userRepository.fetchUsers(pageNumber: pageNumber);
        final colourResponse =
            await colourRepository.fetchColours(pageNumber: pageNumber);
        yield UserColourSuccessState(
            users: userResponse.data,
            colours: colourResponse?.data ?? [],
            total: userResponse.totalResults);
        // номер страницы увеличивается только в случае, если она не последняя
        if (userResponse.data.isNotEmpty) pageNumber++;
      } else if (event is UserColourFindEvent) {
        yield UserColourLoadingByNameState();
        final userResponse = await userRepository.getUsersByName(
            total: event.totalUserNumber, name: event.name);
        // чтобы отобразить индикатор загрузки
        await Future.delayed(Duration(milliseconds: 200));
        yield UserColourFindState(users: userResponse);
      } else if (event is UserColourClearEvent) {
        yield UserColourSuccessState(users: [], colours: []);
      }
    } catch (error) {
      yield UserColourFailureState(error: error.toString());
    }
  }
}
