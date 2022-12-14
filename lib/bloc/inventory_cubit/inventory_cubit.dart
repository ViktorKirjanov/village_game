import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit() : super(const InventoryState(friends: 0, items: 0));

  void incrementFriends() => emit(
        state.copyWith(
          friends: state.friends + 1,
        ),
      );

  void incrementItems() => emit(
        state.copyWith(
          items: state.items + 1,
        ),
      );
}
