import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:village_game/flame_layer/village_game.dart';

class BakedGoodComponent extends SpriteComponent
    with CollisionCallbacks, HasGameRef<VillageGame> {
  @override
  Future<void> onLoad() async {
    await add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    gameRef.inventoryCubit.increaseItems();
    removeFromParent();
  }
}
