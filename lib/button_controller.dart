import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:village_game/main.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({super.key, required this.game});

  final VillageGame game;

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController> {
  var _isPlaying = false;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                icon: Icon(
                  _isPlaying
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  _isPlaying
                      ? FlameAudio.bgm.stop()
                      : FlameAudio.bgm.play('smile.mp3');
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
            ),
            if (_isPlaying)
              Text(
                widget.game.soundTrackName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
          ],
        ),
      );
}
