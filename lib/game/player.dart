import 'package:dino_flames/game/flutter.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

import 'enemy.dart';
import 'game.dart';

class Player extends SpriteComponent
    with KeyboardHandler, HasGameRef<DinoGame>, CollisionCallbacks {
  // Gives the Power to the class to reach to theses different classes and use their methods and variables
  bool onGround = true;
  Player({super.sprite}) {
    size = Vector2(150, 150);
    position = Vector2(50, 100);
    add(RectangleHitbox());
  }
  late double delta;

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    y = gameRef.ground - 50;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    if (y < gameRef.ground + 50) {
      onGround = false;
      y += (dt * 270);
    }
    if (y > gameRef.ground + 50) {
      onGround = true;
    }
    delta = dt;
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space) && onGround) {
      y -= gameRef.size.y / 1.5;
    }
    return true;
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    // TODO: implement onCollisionEnd
    if (other is Enemy) {}
    if (other is Flutter) {}
    super.onCollisionEnd(other);
  }

  void jump() {
    if (onGround) {
      y -= gameRef.size.y / 2;
    }
    if (y < gameRef.ground + 50) {
      onGround = false;
    }
    if (y > gameRef.ground + 50) {
      onGround = true;
    }
  }
}
