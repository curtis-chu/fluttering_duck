import 'package:flutter/material.dart';
import '../common.dart';

class BrickWall extends StatelessWidget {
  late double width;
  late double height;
  late double left;
  late double initLeft;
  late double top;
  late double initTop;
  late double velocity;
  late double gravity;
  late int state;

  BrickWall(
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
    initLeft = left;
    initTop = top;
  }

  /// 移動
  void moves() {
    velocity = velocity + gravity;
    left += velocity;

    if (left <= 0) {
      left = initLeft;
    }
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
     print('wall rect$left, $top, $width, $height');
    return Rect.fromLTWH(left, top, width, height);
  }

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
            border: Border.all(width: 10, color: Colors.blueAccent),
          ),
        ));
  }
}
