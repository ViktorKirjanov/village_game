import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:village_game/bloc/inventory_cubit/inventory_cubit.dart';
import 'package:village_game/flame_layer/village_game.dart';

class FlameLayer extends StatelessWidget {
  const FlameLayer({super.key});

  @override
  Widget build(BuildContext context) => GameWidget(
        game: VillageGame(
          inventoryCubit: context.read<InventoryCubit>(),
        ),
      );
}
