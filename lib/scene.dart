import 'package:flutter/material.dart';
import 'package:fluttering_duck/characters/BrickWall.dart';
import 'dart:async';
import 'characters/Duck.dart';
import 'characters/Cloud.dart';
import 'dart:math';
import 'characters/FlyButton.dart';
import 'characters/ScoreBoard.dart';
import 'package:audioplayers/audioplayers.dart';

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
  static const gravity = 0.3; // 虛擬世界重力。單位: pixel / frame
  late Duck duck;
  late Cloud cloud1;
  late Cloud cloud2;
  late ScoreBoard scoreBoard;
  late BrickWall brickWall;
  late FlyButton flyButton;
  late int score;
  final bgmPlayer = AudioPlayer();
  final duckPlayer = AudioPlayer();
  late bool start = false;

  /// 放角色的地方
  List<Widget> characters = [];

  @override
  void initState() {
    super.initState();

    print('appHeight=${widget.appHeight} appWidth=${widget.appWidth}');

    /** 背景音樂結束後重新播放 */
    bgmPlayer.onPlayerComplete.listen((event) {
      print('bgm reload');
      bgmPlayer.resume();
    });

    /** 鴨子放在離左側 30% 距上方 50% 處 */
    duck = Duck(
        left: (widget.appWidth * 0.3) - (duckSize / 2),
        top: (widget.appHeight * 0.5) - (duckSize / 2),
        width: 120,
        height: 120);
    duck.init(-12, gravity);

    /** 計分板放在右上 */
    scoreBoard = ScoreBoard(
        left: widget.appWidth * 0.7, top: 0, width: 300, height: 120);
    scoreBoard.init(0, 0);

    /** 控制按鈕放在左下 */
    flyButton = FlyButton(
        left: 0, top: widget.appHeight - 120, width: 120, height: 120);
    flyButton.init(0, 0);
    flyButton.setAction(flyAction);

    /** 其他角色隨意放 */
    cloud1 = Cloud(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble(),
        width: 200,
        height: 120);
    cloud1.init(-2, 0);

    cloud2 = Cloud(
        left: widget.appWidth,
        top: Random().nextInt(widget.appHeight.toInt()).toDouble(),
        width: 120,
        height: 120);
    cloud2.init(-3, 0);

    brickWall =
        BrickWall(left: widget.appWidth * 0.7, top: 0, width: 60, height: 120);
    brickWall.init(0, 0);

    /** 分數初始化 */
    score = 0;

    setState(() {
      /** 清空角色 */
      characters.clear();
      /** 佈置角色 */
      characters.add(duck.build(context));
    });

    /** 計時器 60fps */
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        /** 清空角色 */
        characters.clear();

        /** 計分 */
        score = 1000;
        scoreBoard.setStatus(score);

        /** 鴨子 */
        var isDead = isDuckDead();
        if (isDead) {
          duck.setStatus(DuckState.dead);
        } else {
          duck.setStatus(DuckState.alive);
        }
        duck.moves();

        /** 其他 */
        cloud1.moves();
        cloud2.moves();

        /** 佈置角色 */
        characters.add(duck.build(context));
        characters.add(scoreBoard.build(context));
        characters.add(flyButton.build(context));
        characters.add(cloud1.build(context));
        characters.add(cloud2.build(context));
        characters.add(brickWall.build(context));
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
    var position = duck.getPosition();
    /** 撞到底部死了 */
    if (position.top + duckSize > widget.appHeight) {
      return true;
    }
    /** 飛天死了 */
    if (position.top + duckSize < 0) {
      return true;
    }
    /** 左邊撞死了 */
    if (position.left + duckSize < 0) {
      return true;
    }
    /** 右邊撞死了 */
    if (position.left + duckSize > widget.appWidth) {
      return true;
    }
    return false;
  }

  ///鴨子要飛
  Future<void> flyAction() async {
    /** 
     * BGM 放在這裡啟動
     * 在 chrome 66 後需要使用者與介面互動後才能播放背景音
     * 錯誤訊息: play() failed because the user didn't interact with the document first.
     * https://github.com/bluefireteam/audioplayers/issues/831
     */
    if (!start) {
      /** 在 hot reload 後背景音會重複播放 */
      bgmPlayer.play(UrlSource('sounds/bgm.mp3'));
      start = true;
    }

    duck.fly();
  }
}
