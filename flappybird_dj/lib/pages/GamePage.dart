import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappybird_dj/componentes/background.dart';
import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flappybird_dj/componentes/ground.dart';
import 'package:flappybird_dj/componentes/pipe_group.dart';
import 'package:flappybird_dj/other/configuration.dart';

class GamePage extends FlameGame with TapDetector, HasCollisionDetection{
  GamePage();

  late Bird bird;
  Timer interval = Timer(Configuration.pipeInterval, repeat: true);
  bool isHit = false;
  
  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
    ]);

    interval.onTick = () => add(PipeGroup());
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
  }
}




