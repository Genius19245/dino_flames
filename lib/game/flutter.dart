import 'dart:math';

import 'package:dino_flames/game/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'game.dart';

class Flutter extends SpriteComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  late double speed = gameRef.size.x / 150;
  late Random _random = Random();
  late Timer timerComponent;

  Flutter({super.sprite}) {
    size = Vector2(100, 150);
    position = Vector2(1200, 410);
    add(CircleHitbox());
  }

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    y = 400;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    x -= speed;
    if (x < -90) {
      x = gameRef.size.x + 10;
    }
    speed = 5;
    angle += 0.01;
    anchor = Anchor.topLeft;

    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    speed = gameRef.size.x / 275;
    super.onGameResize(size);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    if (other is Player) {
      gameRef.score += 50;
      gameRef.health.value += 1;
    }
    super.onCollisionEnd(other);
  }
}
