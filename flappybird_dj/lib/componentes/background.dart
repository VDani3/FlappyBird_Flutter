import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/pages/GamePage.dart';

class Background extends SpriteComponent with HasGameRef<GamePage>{
  Background();

  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}