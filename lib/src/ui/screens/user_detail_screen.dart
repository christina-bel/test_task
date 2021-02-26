import 'package:flutter/material.dart';
import 'package:flutter_test_task/src/models/user_model.dart';
import 'package:flutter_test_task/src/ui/components/icon_back_button.dart';
import 'package:flutter_test_task/src/ui/screens/animation_screen.dart';

/// Экран пользователя
class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    IconBackButton(
                      onPress: () => Navigator.of(context).pop(),
                    ),
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width * 0.6),
                        child: Text(
                          '${user.firstName}\n${user.lastName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ShipporiMincho',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 35.0,
                ),
                Hero(
                  tag: 'avatar${user.id}',
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 45.0),
                    child: CircleAvatar(
                      radius: 105,
                      backgroundColor: Color(0xFF6881aa),
                      backgroundImage: NetworkImage(
                        user.avatar,
                      ),
                      child: user.avatar == ''
                          ? Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 95,
                            )
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.0),
                  child: Text(
                    'About some thing',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                  'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(
                    height: 1.4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 45.0, bottom: 10.0),
                  child: Text(
                    'Duration',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('1h 30 min'),
                SizedBox(
                  height: 45.0,
                ),
                Center(
                  child: Material(
                    elevation: 3.0,
                    color: Color(0xFF00839D),
                    borderRadius: BorderRadius.circular(22.0),
                    child: MaterialButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimationScreen(),
                        ),
                      ),
                      minWidth: size.width * 0.83,
                      height: 60.0,
                      child: Text(
                        'Show animation (Task 1)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
