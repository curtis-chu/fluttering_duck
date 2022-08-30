import 'package:flutter/material.dart';
import 'package:fluttering_duck/characters/BrickWall.dart';
import 'dart:async';
import 'characters/AliveDuck.dart';
import 'characters/Cloud.dart';
import 'dart:math';
import 'characters/DeadDuck.dart';
import 'characters/FlyButton.dart';
import 'characters/Score.dart';

class Scene extends StatefulWidget {
  late double appWidth;
  late double appHeight;

  Scene({Key? key, required this.appWidth, required this.appHeight})
      : super(key: key);

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> with SingleTickerProviderStateMixin {
  static const int duckSize = 120;
  static const acceleration = 0.3;

  /// 虛擬世界加速度。單位: pixel / frame

  late Position duckPosition;
  late Position cloudPosition;
  late Position cloud2Position;
  late Position brickWallPosition;
  late double duckVelocity;
  late int score;

  /// 放角色的地方
  List<Widget> characters = [];

  @override
  void initState() {
    super.initState();

    print('appHeight=${widget.appHeight} appWidth=${widget.appWidth}');

    /** 分數初始化 */
    score = 0;

    /** 鴨子位置初始化，約放在離左側 30% 距上方 50% 處 */
    duckPosition = Position(
        left: (widget.appWidth * 0.3) - (duckSize / 2),
        top: (widget.appHeight * 0.5) - (duckSize / 2));

    /** 鴨子初始速度 */
    duckVelocity = -12;

    /** 雲位置初始化 */
    cloudPosition = Position(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble());

    cloud2Position = Position(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble() + 80);

    /** 牆位置初始化 */
    brickWallPosition = Position(left: widget.appWidth * 0.7, top: 0);

    setState(() {
      /** 清空角色 */
      characters.clear();
      /** 佈置角色 */
      characters.add(AliveDuck(
          left: duckPosition.left,
          top: duckPosition.top,
          width: 120,
          height: 120));
    });

    /** 計時器 */
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        /** 清空角色 */
        characters.clear();

        /** 移動 */
        duckMoves();
        cloudMoves();
        cloud2Moves();
        var isDead = isDuckDead();

        /** 佈置角色 */
        characters.add(isDead
            ? DeadDuck(
                left: duckPosition.left,
                top: duckPosition.top,
                width: 120,
                height: 120)
            : AliveDuck(
                left: duckPosition.left,
                top: duckPosition.top,
                width: 120,
                height: 120));

        /** 佈置計分板 */
        characters.add(Score(
            left: widget.appWidth * 0.7,
            top: 0,
            width: 300,
            height: 120,
            score: score));

        /** 設置雲 */
        characters.add(Cloud(
            left: cloudPosition.left,
            top: cloudPosition.top,
            width: 200,
            height: 120));

        /** 設置雲 */
        characters.add(Cloud(
            left: cloudPosition.left,
            top: cloudPosition.top,
            width: 120,
            height: 120));

        /** 設置牆 */
        characters.add(BrickWall(
            left: brickWallPosition.left,
            top: brickWallPosition.top,
            width: 60,
            height: 120));

        /** 設置牆 */
        characters.add(FlyButton(
          left: 0,
          top: widget.appHeight - 120,
          width: 120,
          height: 120,
          flyAction: flyAction,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: characters,
    );
  }

  /// 鴨子的各種死法
  bool isDuckDead() {
    /** 撞到底部死了 */
    if (duckPosition.top + duckSize > widget.appHeight) {
      return true;
    }
    /** 飛天死了 */
    if (duckPosition.top + duckSize < 0) {
      return true;
    }
    /** 左邊撞死了 */
    if (duckPosition.left + duckSize < 0) {
      return true;
    }
    /** 右邊撞死了 */
    if (duckPosition.left + duckSize > widget.appWidth) {
      return true;
    }
    return false;
  }
  ///鴨子動
  void duckMoves() {
    /** 重力加速度 */
    duckVelocity = duckVelocity + acceleration;
    duckPosition.top += duckVelocity;
  }

  ///雲動
  void cloudMoves() {
    cloudPosition.left -= 2;
    if (cloudPosition.left + 300 < 0) {
      cloudPosition.left = widget.appWidth;
      cloudPosition.top = Random().nextInt(widget.appHeight.toInt()).toDouble();
    }
  }

  ///雲2動
  void cloud2Moves() {
    cloud2Position.left -= 1;
    if (cloud2Position.left + 300 < 0) {
      cloud2Position.left = widget.appWidth;
      cloud2Position.top =
          Random().nextInt(widget.appHeight.toInt()).toDouble();
    }
  }

  ///鴨子要飛
  void flyAction() {

  }
}

class Position {
  double left;
  double top;
  Position({required this.left, required this.top});
}