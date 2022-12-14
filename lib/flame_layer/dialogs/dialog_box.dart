import 'dart:ui';

import 'package:flame/components.dart';
import 'package:village_game/flame_layer/village_game.dart';

class DialogBox extends TextBoxComponent {
  DialogBox({required String text, required this.game})
      : super(
          text: text,
          position: game.size,
          boxConfig: TextBoxConfig(
            dismissDelay: 5.0,
            maxWidth: game.size.x * .5,
            timePerChar: 0.1,
          ),
        ) {
    anchor = Anchor.bottomRight;
  }

  final VillageGame game;

  @override
  void drawBackground(Canvas c) {
    final Rect rect = Rect.fromLTWH(0, 0, width, height);
    c.drawRect(
      rect,
      Paint()..color = const Color(0x8f37474f),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (finished) {
      game.remove(this);
    }
  }
}
