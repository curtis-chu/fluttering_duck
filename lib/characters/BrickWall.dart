import 'package:flutter/material.dart';

class BrickWall extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;

  const BrickWall(
      {Key? key,
      required this.left,
      required this.top,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        child: Container(
          width: width,
          height: 300,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("images/brick_wall.png"),
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeat,
            ),
            border: Border.all(color: Colors.blueAccent),
          ),
        ));
  }
}
