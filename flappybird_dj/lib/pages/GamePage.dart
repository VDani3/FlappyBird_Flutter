import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappybird_dj/componentes/background.dart';
import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flappybird_dj/componentes/ground.dart';
import 'package:flappybird_dj/componentes/pipe_group.dart';
import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends FlameGame with TapDetector, HasCollisionDetection {
  GamePage();

  late Bird bird, bird2, bird3;
  late TextBoxComponent score;
  Timer interval = Timer(Configuration.pipeInterval, repeat: true);
  bool isHit = false;
  AppData data = AppData.instance;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = data.playersList[0],
      bird2 = data.playersList[1],
      bird3 = data.playersList[2],
      bird3 = data.playersList[3],
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextBoxComponent buildScore() {
    return TextBoxComponent(
        text: 'Score: 0',
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Game')));
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = "Score: ${bird.score}";
  }
}
