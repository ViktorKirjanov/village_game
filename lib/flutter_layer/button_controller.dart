import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:village_game/bloc/cubit/background_sound_cubit.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({super.key});

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: BlocBuilder<BackgroundSoundCubit, BackgroundSoundState>(
          builder: (_, state) => Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    state.isPlaying
                        ? Icons.volume_up_rounded
                        : Icons.volume_off_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => context.read<BackgroundSoundCubit>().onoff(),
                ),
                if (state.isPlaying)
                  Text(
                    state.filaeName,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
