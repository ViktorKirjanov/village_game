import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:village_game/flame_layer/actors/friend.dart';
import 'package:village_game/flame_layer/village_game.dart';

Future<void> addFriends(
  TiledComponent mapComponent,
  VillageGame game,
) async {
  final friendsGroup = mapComponent.tileMap.getLayer<ObjectGroup>('Friends');
  for (final friend in friendsGroup!.objects) {
    await game.add(
      FriendComponent()
        ..position = Vector2(friend.x, friend.y)
        ..width = friend.width
        ..height = friend.height
        ..debugMode = true,
    );
  }
}
