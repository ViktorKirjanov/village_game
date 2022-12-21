import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:village_game/flame_layer/actors/hero.dart';
import 'package:village_game/flame_layer/village_game.dart';

class ObstacleComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<VillageGame> {
  ObstacleComponent(this.obstacle);

  bool _isCollided = false;

  final TiledObject obstacle;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(obstacle.x, obstacle.y);
    size = Vector2(obstacle.width, obstacle.height);
    debugMode = true;
    await add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is HeroComponent) {
      if (!_isCollided) {
        _isCollided = true;
        gameRef.collisionDirection = gameRef.direction;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is HeroComponent) {
      _isCollided = false;
      gameRef.collisionDirection = null;
      super.onCollisionEnd(other);
    }
  }
}
