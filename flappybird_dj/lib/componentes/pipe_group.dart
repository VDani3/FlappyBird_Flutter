import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybird_dj/componentes/pipe.dart';
import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/other/configuration.dart';
import 'package:flappybird_dj/other/pipe_position.dart';
import 'package:flappybird_dj/pages/GamePage.dart';

class PipeGroup extends PositionComponent with HasGameRef<GamePage> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Configuration.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll([
      Pipe(height: centerY - spacing / 2, pipePosition: PipePosition.top),
      Pipe(
          height: heightMinusGround - (centerY + spacing / 2),
          pipePosition: PipePosition.bottom),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Configuration.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (AppData.instance.gameover) {
      removeFromParent();
      //gameRef.isHit = false;
    }
  }

  void updateScore() {
    if (AppData.instance.playersList[AppData.instance.myIdNum].fainted == false) {
      AppData.instance.playersList[AppData.instance.myIdNum].score += 1;
      FlameAudio.play(Assets.point);
    }
  }
}
