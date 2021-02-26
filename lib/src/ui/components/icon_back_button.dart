import 'package:flutter/material.dart';

/// Кнопка с иконкой возвращения
class IconBackButton extends StatelessWidget {
  final Function onPress;

  IconBackButton({@required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPress,
        icon: Icon(
          Icons.arrow_back,
          size: 22.0,
          color: Colors.black,
        ),
      ),
    );
  }
}
