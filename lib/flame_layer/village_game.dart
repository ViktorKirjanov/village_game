import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:village_game/bloc/dialog_cubit/dialog_cubit.dart';
import 'package:village_game/bloc/inventory_cubit/inventory_cubit.dart';
import 'package:village_game/flame_layer/actors/hero.dart';
import 'package:village_game/flame_layer/loaders/add_baked_goods.dart';
import 'package:village_game/flame_layer/loaders/add_friends.dart';
import 'package:village_game/flame_layer/loaders/add_obstacle.dart';

enum Direction { idle, down, left, top, right }

class VillageGame extends FlameGame with TapDetector, HasCollisionDetection {
  VillageGame({
    required this.inventoryCubit,
    required this.dialogCubit,
  });

  final InventoryCubit inventoryCubit;
  final DialogCubit dialogCubit;

  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation idleAnimation;
  final double animationSpeed = .15;
  final double characterSpeed = 100;
  final String soundTrackName = 'smile';

  late HeroComponent character;
  late TiledComponent mapComponent;
  late double mapWidth;
  late double mapHeight;

  Direction direction = Direction.idle;
  Direction? collisionDirection;

  String initDialogMessage = 'Hi.  I am George.  I have just '
      'moved to Happy Bay Village. '
      'I want to make friends.';

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // add audio
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load('smile.mp3');

    // add map
    mapComponent = await TiledComponent.load('village_2.tmx', Vector2.all(16));
    await add(mapComponent);
    mapWidth = mapComponent.tileMap.map.width * 16.0;
    mapHeight = mapComponent.tileMap.map.height * 16.0;

    // add character
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

    character = HeroComponent()
      ..animation = downAnimation
      ..position = Vector2(600, 300)
      ..size = Vector2.all(48 * 1.5)
      ..debugMode = true
      ..debugColor = Colors.red;

    await addBakedGoods(mapComponent, this);
    await addObstacle(mapComponent, this);
    await addFriends(mapComponent, this);
    await add(character);

    // add init dialog
    dialogCubit.addDialog(initDialogMessage);

    // add camera
    camera.followComponent(
      character,
      worldBounds: Rect.fromLTWH(
        .0,
        .0,
        mapWidth,
        mapHeight,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (direction) {
      case Direction.idle:
        character.animation = idleAnimation;
        break;
      case Direction.down:
        character.animation = downAnimation;
        if (character.y < mapHeight - character.height) {
          if (collisionDirection != Direction.down) {
            character.y += dt * characterSpeed;
          }
        }
        break;
      case Direction.left:
        character.animation = leftAnimation;
        if (character.x > 0) {
          if (collisionDirection != Direction.left) {
            character.x -= dt * characterSpeed;
          }
        }
        break;
      case Direction.top:
        character.animation = upAnimation;
        if (character.y > 0) {
          if (collisionDirection != Direction.top) {
            character.y -= dt * characterSpeed;
          }
        }
        break;
      case Direction.right:
        character.animation = rightAnimation;
        if (character.x < mapWidth - character.width) {
          if (collisionDirection != Direction.right) {
            character.x += dt * characterSpeed;
          }
        }
        break;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    switch (direction) {
      case Direction.idle:
        direction = Direction.down;
        break;
      case Direction.down:
        direction = Direction.left;
        break;
      case Direction.left:
        direction = Direction.top;
        break;
      case Direction.top:
        direction = Direction.right;
        break;
      case Direction.right:
        direction = Direction.idle;
        break;
    }
  }
}
