import 'package:flutter/material.dart';
import 'package:village_game/flutter_layer/button_controller.dart';
import 'package:village_game/flutter_layer/dashboard_controller.dart';
import 'package:village_game/flutter_layer/dialoig_overlay.dart';

class FlutterLayer extends StatelessWidget {
  const FlutterLayer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ButtonController(),
              DashboardController(),
            ],
          ),
          const Spacer(),
          const DialogOverlay(),
        ],
      );
}
