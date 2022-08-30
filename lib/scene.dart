import 'package:flutter/material.dart';
import 'package:fluttering_duck/utilities.dart';
import 'dart:async';
import 'characters.dart';
import 'dart:math';

class Scene extends StatefulWidget {
  double appWidth;
  double appHeight;

  Scene({Key? key, required this.appWidth, required this.appHeight})
      : super(key: key);

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> with SingleTickerProviderStateMixin {
  AliveDuck duck = const AliveDuck(width: 120, height: 120);
  DeadDuck deadDuck = const DeadDuck(width: 120, height: 120);
  Cloud cloud = const Cloud(width: 200, height: 120);
  Cloud cloud2 = const Cloud(width: 150, height: 120);

  late Pos duckPos;
  late Pos cloudPos;
  late Pos cloudPos2;
  List<Widget> characters = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    /** 鴨子位置初始化，約放在離左側 30% 距上方 50% 處 */
    duckPos = Pos(
        left: (widget.appWidth * 0.3) - (duck.width / 2),
        top: (widget.appHeight * 0.5) - (duck.height / 2));

    cloudPos = Pos(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble());

    cloudPos2 = Pos(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble() + 80);

    print('top=${widget.appHeight}');

    /** 計時器 */
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        /** 清空角色 */
        characters.clear();

        duckMoves();
        cloudMoves();
        cloud2Moves();

        /** 佈置角色 */
        var isDead = isDuckDead();
        characters.add(Positioned(
          left: duckPos.left,
          top: duckPos.top,
          child: isDead ? deadDuck : duck,
        ));

        /** 佈置計分板 */
        if (!isDead) score += 50;
        characters.add(Positioned(
            left: widget.appWidth - 300,
            top: 0,
            child: Text(
              'SCORE: ${score.toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                  fontSize: 40),
            )));

        /** 設置雲 */
        characters.add(
            Positioned(left: cloudPos.left, top: cloudPos.top, child: cloud));
        /** 設置雲 */
        characters.add(
            Positioned(left: cloudPos2.left, top: cloudPos2.top, child: cloud2));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(
      alignment: Alignment.topLeft,
      children: characters,
    );
  }

  bool isDuckDead() {
    if (duckPos.top + (duck.height / 2) > widget.appHeight) {
      return true;
    }
    if (duckPos.top + (duck.height / 2) < 0) {
      return true;
    }
    if (duckPos.left + (duck.width / 2) < 0) {
      return true;
    }
    if (duckPos.left + (duck.width / 2) > widget.appWidth) {
      return true;
    }
    return false;
  }

  void duckMoves() {
    duckPos.top += 2;
  }

  void cloudMoves() {
    cloudPos.left -= 2;
    if (cloudPos.left + 300 < 0) {
      cloudPos.left = widget.appWidth;
      cloudPos.top = Random().nextInt(widget.appHeight.toInt()).toDouble();
    }
  }
  void cloud2Moves() {
    cloudPos2.left -= 1;
    if (cloudPos2.left + 300 < 0) {
      cloudPos2.left = widget.appWidth;
      cloudPos2.top = Random().nextInt(widget.appHeight.toInt()).toDouble();
    }
  }
}
