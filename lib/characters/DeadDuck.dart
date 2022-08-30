import 'package:flutter/material.dart';

class DeadDuck extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;

  const DeadDuck(
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
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/dead_duck.png"),
              fit: BoxFit.scaleDown,
            ),
            // border: Border.all(color: Colors.blueAccent),
          ),
        ));
  }
}
