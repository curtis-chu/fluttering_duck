import 'package:flutter/material.dart';

class AliveDuck extends StatelessWidget {
  final double width;
  final double height;

  const AliveDuck({ Key? key, required this.width, required this.height }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/live_duck.png"),
            fit: BoxFit.scaleDown,
          ),
          // border: Border.all(color: Colors.blueAccent),
        ),
      );
  }
}

class DeadDuck extends StatelessWidget {
  final double width;
  final double height;

  const DeadDuck({ Key? key, required this.width, required this.height }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/dead_duck.png"),
            fit: BoxFit.fill,
          ),
        ),
      );
  }
}


class Cloud extends StatelessWidget {
  final double width;
  final double height;

  const Cloud({ Key? key, required this.width, required this.height }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/cloud.png"),
            fit: BoxFit.fill,
          ),
        ),
      );
  }
}
