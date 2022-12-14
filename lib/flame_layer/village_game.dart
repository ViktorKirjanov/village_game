import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:village_game/bloc/inventory_cubit/inventory_cubit.dart';
import 'package:village_game/flame_layer/actors/hero.dart';
import 'package:village_game/flame_layer/dialogs/dialog_box.dart';
import 'package:village_game/flame_layer/loaders/add_baked_goods.dart';
import 'package:village_game/flame_layer/loaders/add_friends.dart';

enum Direction { idle, down, left, top, right }

class VillageGame extends FlameGame with TapDetector, HasCollisionDetection {
  VillageGame({required this.inventoryCubit});

  final InventoryCubit inventoryCubit;

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

  late DialogBox dialogBox;

  String dialogMessage = 'Hi.  I am George.  I have just '
      'moved to Happy Bay Village. '
      'I want to make friends.';

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // add audio
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load('smile.mp3');

    // add map
    mapComponent = await TiledComponent.load('village.tmx', Vector2.all(16));
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
      ..position = Vector2(100, 100)
      ..size = Vector2.all(48 * 2)
      ..debugMode = true
      ..debugColor = Colors.red;

    await addBakedGoods(mapComponent, this);
    await addFriends(mapComponent, this);
    await add(character);

    // add init dialog
    dialogBox = DialogBox(text: dialogMessage, game: this);
    await add(dialogBox);

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
        if (character.x < mapWidth - character.width) {
          character.x += dt * characterSpeed;
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
