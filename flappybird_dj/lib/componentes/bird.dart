import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybird_dj/componentes/ground.dart';
import 'package:flappybird_dj/componentes/pipe.dart';
import 'package:flappybird_dj/componentes/pipe_group.dart';
import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/other/birdmovement.dart';
import 'package:flappybird_dj/other/configuration.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<GamePage>, CollisionCallbacks {

  Bird({bool p = false, String name = "YOU", id = 0, f = false}) : super() {
    this.p1 = p;
    this.name = name;
    this.id = id;
    this.fainted = f;
  }

  String name = "YOU";
  bool p1 = false;
  bool fainted = false;
  int score = 0;
  int id = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await _loadImage(Assets.birdMidFlap[id]);
    final birdUpFlap = await _loadImage(Assets.birdUpFlap[id]);
    final birdDownFlap = await _loadImage(Assets.birdDownFlap[id]);
    final birdDeath = await _loadImage(Assets.birdTomb);

    size = Vector2(35, 35);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
      BirdMovement.death: birdDeath
    };

    if (p1) {
      add(CircleHitbox());
      add(TextBoxComponent(
        text: name,
        position: Vector2(position.x+(size.x*2)*0.75, -20),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20)
        )
      ));
    }
  }

  void fly() {
    if (!fainted) {
      add(MoveByEffect(
        Vector2(0, Configuration.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ));
      current = BirdMovement.up;
      FlameAudio.play(Assets.flying);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if ((other is PipeGroup || other is Pipe || other is Ground) && p1) {
      fainted = true;
      current = BirdMovement.death;
      AppData.instance.setFainted(id);
      AppData.instance.sendFainted();
    }
  }

  void gameOver() {
    FlameAudio.play(Assets.collision);
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    name = "Waiting...";
    score = 0;
    //fainted = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (p1 && !fainted) position.y += Configuration.birdVelocity * dt;
    if (position.y <= 0 && p1) {
      //gameOver();
      AppData.instance.setFainted(id);
      AppData.instance.sendFainted();
    }
    if (AppData.instance.gameover) gameOver();
  }

  void setName(String name) {
    this.name = name;
  }

  int getScore() {
    return score;
  }

  Future<Sprite> _loadImage(String imgPath) async {
    final image = await gameRef.loadSprite(imgPath);
    
    if (!p1) {
      image.paint.color = image.paint.color.withOpacity(0.5);
      print(image);
    }
    
    return image;
  }
}
