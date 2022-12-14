import 'package:equatable/equatable.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'background_sound_state.dart';

class BackgroundSoundCubit extends Cubit<BackgroundSoundState> {
  BackgroundSoundCubit({
    required this.name,
    required this.bgm,
  }) : super(
          BackgroundSoundState(
            isPlaying: false,
            filaeName: name,
          ),
        );

  final Bgm bgm;
  final String name;

  void onoff() {
    state.isPlaying ? bgm.stop() : bgm.play(name);
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }
}
