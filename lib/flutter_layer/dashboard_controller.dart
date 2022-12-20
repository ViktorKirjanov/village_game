import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:village_game/bloc/inventory_cubit/inventory_cubit.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({
    super.key,
  });

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              _FriendsCounter(),
              const SizedBox(width: 15.0),
              _ItemsCounter(),
            ],
          ),
        ),
      );
}

class _FriendsCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black38,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 32.0,
              width: 32.0,
              child: Image.asset('assets/images/friend.png'),
            ),
            const SizedBox(width: 5.0),
            BlocBuilder<InventoryCubit, InventoryState>(
              builder: (_, state) => Text(
                state.friends.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ],
        ),
      );
}

class _ItemsCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.black38,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 32.0,
              width: 32.0,
              child: Image.asset('assets/images/22_cheesecake.png'),
            ),
            const SizedBox(width: 5.0),
            BlocBuilder<InventoryCubit, InventoryState>(
              builder: (_, state) => Text(
                state.items.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ],
        ),
      );
}
