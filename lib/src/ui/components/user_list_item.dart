import 'package:flutter/material.dart';
import 'package:flutter_test_task/src/models/colour_model.dart';
import 'package:flutter_test_task/src/models/user_model.dart';
import 'package:flutter_test_task/src/ui/screens/user_detail_screen.dart';

/// Карточка отдельного пользователя
class UserListItem extends StatelessWidget {
  final User user;
  final Colour colour;

  const UserListItem(this.user, this.colour);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 15),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(user: user),
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: 320,
                  color: Color(colour.color),
                ),
                Positioned(
                  top: 195,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 125,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateTime.now().hour} h ${DateTime.now().minute} min',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12.0,
                              wordSpacing: -0.5,
                            ),
                          ),
                          Text(
                            user.firstName + ' ' + user.lastName,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24.0,
                              fontFamily: 'ShipporiMincho',
                            ),
                          ),
                          Text(colour.name),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 20,
                  child: Hero(
                    tag: 'avatar${user.id}',
                    child: Container(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFF6881AA),
                        backgroundImage: NetworkImage(
                          user.avatar,
                        ),
                        child: user.avatar == ''
                            ? Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 65,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
