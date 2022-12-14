import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:village_game/flame_layer/dialogs/dialog_box.dart';
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
      game.dialogMessage = 'Wow.  Thanks so much.  Please come over '
          'this weekend for dinner.  I have to run now. '
          'See you on Saturday at 7pm.';
      gameRef.inventoryCubit.incrementFriends();
      gameRef.inventoryCubit.decreaseItems();
      removeFromParent();
      super.onCollision(intersectionPoints, other);
    } else {
      game.dialogMessage =
          'Great to meet you.  Sorry, I have to run to a meeting.';
    }
    game.dialogBox.removeFromParent();
    game
      ..dialogBox = DialogBox(text: game.dialogMessage, game: game)
      ..add(game.dialogBox);
  }
}
