import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:village_game/bloc/dialog_cubit/dialog_cubit.dart';

class DialogOverlay extends StatelessWidget {
  const DialogOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<DialogCubit, String?>(
        builder: (_, state) => state != null
            ? Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2,
                  bottom: 10.0,
                  right: 10.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white70,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        state,
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                        ),
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    onFinished: () =>
                        context.read<DialogCubit>().removeDialog(),
                  ),
                ),
              )
            : Container(),
      );
}
