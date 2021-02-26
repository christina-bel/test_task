import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/src/bloc/user_colour_bloc.dart';
import 'package:flutter_test_task/src/bloc/user_colour_event.dart';
import 'package:flutter_test_task/src/bloc/user_colour_state.dart';
import 'package:flutter_test_task/src/models/colour_model.dart';
import 'package:flutter_test_task/src/models/user_model.dart';
import 'package:flutter_test_task/src/ui/components/bottom_loader_indicator.dart';
import 'package:flutter_test_task/src/ui/components/icon_back_button.dart';
import 'package:flutter_test_task/src/ui/components/user_list_item.dart';

/// Экран списка пользователей
class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  /// список пользователей
  final List<User> users = [];

  /// список цветов
  final List<Colour> colours = [];

  /// словарь пользователь-цвет (нужен для сохранения уже заданных значений)
  final Map<int, Colour> userColour = {};

  /// контроллеры
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  /// цвет по умолчанию
  final Colour defaultColour =
      Colour({'name': 'default colour', 'color': '#E6EDF4'});

  /// общее кол-во пользователей, полученное из запроса
  int totalUsers = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  // скролл экрана и подгрузка пользователей
  void _onScroll() {
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        !BlocProvider.of<UserColourBloc>(context).isFetching) {
      BlocProvider.of<UserColourBloc>(context)
        ..isFetching = true
        ..add(UserColourFetchedEvent());
    }
  }

  // в словарь сохраняются пользователи с заданным цветом, чтобы он не изменялись при подгрузке новых
  void setColours() {
    users.asMap().forEach((key, value) {
      if (!userColour.containsKey(value.id))
        userColour[value.id] = colours[key % colours.length];
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<UserColourBloc, UserColourState>(
      builder: (context, state) {
        if (state is UserColourInitialState ||
            state is UserColourLoadingUsersState && users.isEmpty ||
            state is UserColourLoadingByNameState) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.7,
            ),
          );
        } else if (state is UserColourSuccessState) {
          users.addAll(state.users);
          colours.addAll(state.colours);
          totalUsers = state.total ?? totalUsers;
          // случайное сопоставление цвета с пользователем
          if (state.users.isNotEmpty && colours.isNotEmpty) {
            colours.shuffle();
            setColours();
          }
          BlocProvider.of<UserColourBloc>(context).isFetching = false;
        } else if (state is UserColourFailureState) {
          BlocProvider.of<UserColourBloc>(context).isFetching = false;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<UserColourBloc>(context)
                    ..isFetching = true
                    ..add(
                      UserColourFetchedEvent(),
                    );
                },
                icon: Icon(Icons.refresh),
              ),
              SizedBox(height: 15),
              Text(state.error, textAlign: TextAlign.center),
            ],
          );
        } else if (state is UserColourFindState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconBackButton(onPress: () {
                        searchController.clear();
                        BlocProvider.of<UserColourBloc>(context)
                            .add(UserColourClearEvent());
                      }),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        child: searchField(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.0),
                    child: Text(
                      '${state.users.length} Results',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  state.users.length != 0
                      ? Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return UserListItem(
                                state.users[index],
                                // если пользователь не был загружен при прокрутке он получает цвет по умолчанию
                                !userColour.containsKey(state.users[index].id)
                                    ? defaultColour
                                    : userColour[state.users[index].id],
                              );
                            },
                            itemCount: state.users.length,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: size.height * 0.27),
                          child: Center(
                            child: Text(
                              'Sorry! No user found:(',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        }
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hello,',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '\nThomas Anderson',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: searchField(),
                ),
                Expanded(
                  child: ListView.builder(
                    key: PageStorageKey('userView'),
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return index >= users.length
                          ? BottomLoaderIndicator()
                          : UserListItem(
                              users[index],
                              // в случае пустого списка цветов/ошибки при приведении цвета в int задается цвет по умолчанию
                              colours.isEmpty ||
                                      userColour[users[index].id].color == null
                                  ? defaultColour
                                  : userColour[users[index].id],
                            );
                    },
                    itemCount:
                        (state is UserColourSuccessState && state.users.isEmpty)
                            ? users.length
                            : users.length + 1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Поиск пользователей
  Widget searchField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextField(
        controller: searchController,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search people',
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          suffixIcon: IconButton(
            onPressed: () {
              if (searchController.text != null) {
                BlocProvider.of<UserColourBloc>(context).add(
                  UserColourFindEvent(
                    totalUserNumber: totalUsers,
                    name:
                        searchController.text.toLowerCase().replaceAll(' ', ''),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
