import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HeroComponent extends SpriteAnimationComponent {
  @override
  Future<void>? onLoad() {
    add(
      RectangleHitbox(
        size: Vector2(60, 60),
        position: Vector2(6, 6),
      )
        ..scale = Vector2(.75, .75)
        ..position = Vector2(15, 15),
    );
    return super.onLoad();
  }
}
