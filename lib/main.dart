import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: VillageGame(),
    ),
  );
}

enum Direction { idle, down, left, top, right }

class VillageGame extends FlameGame with TapDetector {
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;
  final double animationSpeed = .15;
  final double characterSpeed = 100;

  late SpriteAnimationComponent character;
  late SpriteComponent background;

  Direction _direction = Direction.idle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //add background
    final Sprite backgroundSprite = await loadSprite('village_bg.png');
    background = SpriteComponent(
      sprite: backgroundSprite..srcSize = backgroundSprite.originalSize,
    );
    await add(background);

    //add character
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

    character = SpriteAnimationComponent()
      ..animation = downAnimation
      ..position = Vector2(100, 100)
      ..size = Vector2.all(48 * 2);

    await add(character);

    //add camera
    camera.followComponent(
      character,
      worldBounds: Rect.fromLTWH(
        .0,
        .0,
        backgroundSprite.srcSize.x,
        backgroundSprite.srcSize.y,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (_direction) {
      case Direction.idle:
        character.animation = idleAnimation;
        break;
      case Direction.down:
        character.animation = downAnimation;
        if (character.y < background.size.y - character.height) {
          character.y += dt * characterSpeed;
        }
        break;
      case Direction.left:
        character.animation = leftAnimation;
        if (character.x > 0) {
          character.x -= dt * characterSpeed;
        }
        break;
      case Direction.top:
        character.animation = upAnimation;
        if (character.y > 0) {
          character.y -= dt * characterSpeed;
        }
        break;
      case Direction.right:
        character.animation = rightAnimation;
        if (character.x < background.size.x - character.width) {
          character.x += dt * characterSpeed;
        }
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
