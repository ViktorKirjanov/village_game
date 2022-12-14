part of 'inventory_cubit.dart';

class InventoryState extends Equatable {
  const InventoryState({
    required this.friends,
    required this.items,
  });

  final int friends;
  final int items;

  InventoryState copyWith({
    int? friends,
    int? items,
  }) =>
      InventoryState(
        friends: friends ?? this.friends,
        items: items ?? this.items,
      );

  @override
  List<Object?> get props => [friends, items];
}
