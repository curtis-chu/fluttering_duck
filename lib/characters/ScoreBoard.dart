import 'package:flutter/material.dart';
import '../common.dart';

class ScoreBoard extends StatelessWidget {
  late double width;
  late double height;
  late double left;
  late double top;
  late double velocity;
  late double gravity;
  late int state;

  ScoreBoard(
      {Key? key,
      required this.left,
      required this.top,
      required this.width,
      required this.height})
      : super(key: key);

  /// 初始化
  void init(double v, double g) {
    velocity = v;
    gravity = g;
    setStatus(0);
  }

  /// 移動
  void moves() {
    velocity = velocity + gravity;
    left += velocity;
  }

  /// 速度
  void setVelocity(double v, double g) {
    velocity = v;
    gravity = g;
  }

  /// 狀態
  void setStatus(int s) {
    state = s;
  }

  /// 回傳當前位置
  Position getPosition() {
    return Position(left: left, top: top);
  }

  /// 回傳佔位，可用來做碰撞偵測
  Rect getRect() {
    return Rect.fromLTWH(left, top, width, height);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        child: SizedBox(
          width: width,
          height: height,
          child: Text(
            'SCORE: ${state.toString()}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
                fontSize: 30),
          ),
        ));
  }
}
