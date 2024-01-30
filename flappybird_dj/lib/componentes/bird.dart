import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/other/birdmovement.dart';
import 'package:flappybird_dj/other/configuration.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/animation.dart';

class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<GamePage>, CollisionCallbacks {
  Bird();

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y/2 - size.y /2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap
    };

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Configuration.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      )
    );
    current = BirdMovement.up;
  }

  @override
  void onCollisionStart( Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y +=Configuration.birdVelocity * dt;
    
  }
}




