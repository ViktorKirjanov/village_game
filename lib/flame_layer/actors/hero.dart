import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HeroComponent extends SpriteAnimationComponent with CollisionCallbacks {
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
