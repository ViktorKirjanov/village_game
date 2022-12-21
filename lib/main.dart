import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:village_game/bloc/background_sound_cubit/background_sound_cubit.dart';
import 'package:village_game/bloc/bloc_observer.dart';
import 'package:village_game/bloc/dialog_cubit/dialog_cubit.dart';
import 'package:village_game/bloc/inventory_cubit/inventory_cubit.dart';
import 'package:village_game/flame_layer/flame_layer.dart';
import 'package:village_game/flutter_layer/flutter_layer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Bloc.observer = AppBlocObserver();

  runApp(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InventoryCubit(),
          ),
          BlocProvider(
            create: (context) => BackgroundSoundCubit(
              bgm: FlameAudio.bgm,
              name: 'smile.mp3',
            ),
          ),
          BlocProvider(
            create: (context) => DialogCubit(),
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: const [
              FlameLayer(),
              FlutterLayer(),
            ],
          ),
        ),
      ),
    ),
  );
}
