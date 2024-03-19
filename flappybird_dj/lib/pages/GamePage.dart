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

  late TextBoxComponent score;
  Timer interval = Timer(Configuration.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      AppData.instance.playersList[0],
      AppData.instance.playersList[1],
      AppData.instance.playersList[2],
      AppData.instance.playersList[3],
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
    AppData.instance.playersList[AppData.instance.myIdNum].fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = "Score: ${AppData.instance.playersList[AppData.instance.myIdNum].score}";

    AppData.instance.sendMyPosition();
  }

    void resetGame() {
    AppData.instance.gameover = false;
    for (final child in children) {
      remove(child);
    }

    // Add new birds
    AppData.instance.playersList[0].position = Vector2(50, size.y / 2 - AppData.instance.playersList[0].size.y / 2);
    AppData.instance.playersList[1].position = Vector2(50, size.y / 2 - AppData.instance.playersList[1].size.y / 2);
    AppData.instance.playersList[2].position = Vector2(50, size.y / 2 - AppData.instance.playersList[2].size.y / 2);
    AppData.instance.playersList[3].position = Vector2(50, size.y / 2 - AppData.instance.playersList[3].size.y / 2);
    // Reiniciar estado de los personajes
    AppData.instance.playersList[0].reset();
    AppData.instance.playersList[0].fainted = false;
    AppData.instance.playersList[1].reset();
    AppData.instance.playersList[2].reset();
    AppData.instance.playersList[3].reset();

    addAll([Background(), Ground(), AppData.instance.playersList[0], AppData.instance.playersList[1], AppData.instance.playersList[2], AppData.instance.playersList[3],]);

  }
}

