import 'package:flutter/material.dart';

class FlyButton extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;
  late Function flyAction;

  FlyButton(
      {Key? key,
      required this.left,
      required this.top,
      required this.width,
      required this.height,
      required this.flyAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        child: SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            onPressed: () {
              flyAction();
            },
            child: const Text('Fly'),
          ),
          // border: Border.all(color: Colors.blueAccent),
        ));
  }
}
