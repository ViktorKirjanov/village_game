import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';

void main() {
  runApp(GameWidget(
    game: VillageGame(),
  ));
}

enum Direction { idle, down, left, top, right }

class VillageGame extends FlameGame with TapDetector {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;
  final double animationSpeed = .15;

  late SpriteAnimationComponent _character;
  Direction _direction = Direction.idle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final spriteSheet = SpriteSheet(
      image: await images.load('george2.png'),
      srcSize: Vector2(48.0, 48.0),
    );

    downAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 4);
    leftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: animationSpeed, to: 4);
    upAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: animationSpeed, to: 4);
    rightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: animationSpeed, to: 4);
    idleAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 1);

    _character = SpriteAnimationComponent()
      ..animation = downAnimation
      ..position = Vector2(100, 100)
      ..size = Vector2.all(48 * 3);

    add(_character);
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (_direction) {
      case Direction.idle:
        _character.animation = idleAnimation;
        break;
      case Direction.down:
        _character.animation = downAnimation;
        _character.y += 1;
        break;
      case Direction.left:
        _character.animation = leftAnimation;
        _character.x -= 1;
        break;
      case Direction.top:
        _character.animation = upAnimation;
        _character.y -= 1;
        break;
      case Direction.right:
        _character.animation = rightAnimation;
        _character.x += 1;
        break;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    switch (_direction) {
      case Direction.idle:
        _direction = Direction.down;
        break;
      case Direction.down:
        _direction = Direction.left;
        break;
      case Direction.left:
        _direction = Direction.top;
        break;
      case Direction.top:
        _direction = Direction.right;
        break;
      case Direction.right:
        _direction = Direction.idle;
        break;
    }
  }
}
