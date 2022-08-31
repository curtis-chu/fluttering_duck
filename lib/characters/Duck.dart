import 'package:flutter/material.dart';
import '../common.dart';

class Duck extends StatelessWidget {
  late double width;
  late double height;
  late double left;
  late double top;
  late double velocity;
  late double gravity;
  late DuckState state;

  Duck(
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
    setStatus(DuckState.alive);
  }

  /// 移動
  void moves() {
    velocity = velocity + gravity;
    top += velocity;
  }

  /// 速度
  void setVelocity(double v, double g) {
    velocity = v;
    gravity = g;
  }

  /// 狀態
  void setStatus(DuckState s) {
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
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(state == DuckState.alive
                  ? "images/live_duck.png"
                  : "images/dead_duck.png"),
              fit: BoxFit.fill,
            ),
            // border: Border.all(color: Colors.blueAccent),
          ),
        ));
  }
}

enum DuckState {
  alive,
  dead,
}