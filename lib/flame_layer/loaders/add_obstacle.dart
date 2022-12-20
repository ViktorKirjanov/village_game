import 'package:flame_tiled/flame_tiled.dart';
import 'package:village_game/flame_layer/actors/obstacle.dart';
import 'package:village_game/flame_layer/village_game.dart';

Future<void> addObstacle(
  TiledComponent mapComponent,
  VillageGame game,
) async {
  final obstaclesGroup = mapComponent.tileMap.getLayer<ObjectGroup>('Obstacle');
  for (final obstacle in obstaclesGroup!.objects) {
    await game.add(ObstacleComponent(obstacle));
  }
}
