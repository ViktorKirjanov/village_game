import 'package:flutter/material.dart';
import 'package:village_game/flutter_layer/button_controller.dart';
import 'package:village_game/flutter_layer/dashboard_controller.dart';

class FlutterLayer extends StatelessWidget {
  const FlutterLayer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: const [
          ButtonController(),
          Spacer(),
          DashboardController(),
        ],
      );
}
