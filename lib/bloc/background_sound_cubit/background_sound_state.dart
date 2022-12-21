part of 'background_sound_cubit.dart';

class BackgroundSoundState extends Equatable {
  const BackgroundSoundState({
    required this.isPlaying,
    required this.filaeName,
  });

  final bool isPlaying;
  final String filaeName;

  BackgroundSoundState copyWith({
    bool? isPlaying,
    String? filaeName,
  }) =>
      BackgroundSoundState(
        isPlaying: isPlaying ?? this.isPlaying,
        filaeName: filaeName ?? this.filaeName,
      );

  @override
  List<Object?> get props => [isPlaying, filaeName];
}
