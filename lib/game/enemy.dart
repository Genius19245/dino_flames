import 'package:dino_flames/game/player.dart';
import 'package:dino_flames/game/utils/audioManager.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'game.dart';

class Enemy extends SpriteComponent
    with HasGameRef<DinoGame>, CollisionCallbacks {
  late double speed = gameRef.size.x / 150;

  Enemy({super.sprite}) {
    size = Vector2(125, 125);
    position = Vector2(1000, 350);
    add(CircleHitbox());
  }

  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    y = gameRef.ground + 20;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    x -= speed;
    if (x < -90) {
      x = gameRef.size.x + speed;
    }
    speed = (gameRef.size.x / 190);

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
      AudioManager.playSfx('hit.wav');
      gameRef.health.value -= 1;
    }
    super.onCollisionEnd(other);
  }
}
