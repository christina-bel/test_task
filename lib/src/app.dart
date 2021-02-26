import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/src/bloc/user_colour_event.dart';
import 'package:flutter_test_task/src/resources/colour_repository.dart';
import 'package:flutter_test_task/src/resources/user_repository.dart';
import 'package:flutter_test_task/src/ui/screens/users_list_screen.dart';

import 'bloc/user_colour_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        accentColor: Colors.black,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => UserColourBloc(
            userRepository: UserRepository(),
            colourRepository: ColourRepository(),
          )..add(UserColourFetchedEvent()),
          child: UsersListScreen(),
        ),
      ),
    );
  }
}
