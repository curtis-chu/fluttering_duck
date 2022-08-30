import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final double width;
  final double height;
  final double left;
  final double top;
  final int score;

  const Score(
      {Key? key,
      required this.left,
      required this.top,
      required this.width,
      required this.height,
      required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        child: SizedBox(
          width: width,
          height: height,
          child: Text(
            'SCORE: ${score.toString()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 30),
          ),
        ));
  }
}
