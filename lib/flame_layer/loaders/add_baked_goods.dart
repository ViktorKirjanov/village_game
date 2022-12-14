import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:village_game/flame_layer/actors/baked_good.dart';
import 'package:village_game/flame_layer/village_game.dart';

Future<void> addBakedGoods(
  TiledComponent mapComponent,
  VillageGame game,
) async {
  final bakedGoods = mapComponent.tileMap.getLayer<ObjectGroup>('BakedGoods');
  for (final good in bakedGoods!.objects) {
    late String path;
    switch (good.name) {
      case 'ApplePie':
        path = '05_apple_pie.png';
        break;
      case 'Cheesecake':
        path = '22_cheesecake.png';
        break;
      case 'Cookies':
        path = '28_cookies.png';
        break;
      case 'ChocolateCake':
        path = '30_chocolatecake.png';
        break;
      case 'LemonPie':
        path = '63_lemonpie.png';
        break;
      default:
        path = '01_dish.png';
    }

    await game.add(
      BakedGoodComponent()
        ..position = Vector2(good.x, good.y)
        ..width = good.width
        ..height = good.height
        ..sprite = await game.loadSprite(path)
        ..debugMode = true,
    );
  }
}
