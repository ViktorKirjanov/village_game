import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:village_game/flame_layer/village_game.dart';

class FriendComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<VillageGame> {
  @override
  Future<void> onLoad() async {
    await add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.foundFriends++;
    gameRef.inventoryCubit.incrementFriends();
    removeFromParent();
    super.onCollision(intersectionPoints, other);
  }
}
