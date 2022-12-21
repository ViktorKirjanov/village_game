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
    if (gameRef.inventoryCubit.state.items > 0) {
      const message = 'Wow.  Thanks so much.  Please come over '
          'this weekend for dinner.  I have to run now. '
          'See you on Saturday at 7pm.';

      gameRef.dialogCubit.addDialog(message);
      gameRef.inventoryCubit.incrementFriends();
      gameRef.inventoryCubit.decreaseItems();
      removeFromParent();
      super.onCollision(intersectionPoints, other);
    } else {
      const message = 'Great to meet you.  Sorry, I have to run to a meeting.';
      gameRef.dialogCubit.addDialog(message);
    }
  }
}
