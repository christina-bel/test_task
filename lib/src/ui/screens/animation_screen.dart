import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test_task/src/ui/components/icon_back_button.dart';

/// Экран с анимацией кнопки
class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;

  List<Color> colorsList = [
    Color(0xFF00839D),
    Color(0xFF00D3E5),
  ];

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationRotation =
        Tween<double>(begin: 0, end: pi / 4).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEAC9),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(26.0),
              child: IconBackButton(
                onPress: () => Navigator.of(context).pop(),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) => GestureDetector(
                  onTap: () => controller.status == AnimationStatus.completed
                      ? controller.reverse(from: 1)
                      : controller.forward(),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Transform.rotate(
                      angle: animationRotation.value,
                      child: Icon(
                        Icons.add,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          spreadRadius: 4.5,
                          blurRadius: 7.5,
                          offset: Offset(0, 3),
                        )
                      ],
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        radius: controller.value + 1,
                        center: Alignment.bottomLeft,
                        stops: [
                          0 + controller.value,
                          controller.value,
                          1 - controller.value
                        ],
                        colors: [
                          colorsList[0],
                          colorsList[1],
                          colorsList[1],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
