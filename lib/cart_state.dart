import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String size;
  final String price;
  final int quantity;

  const CartItem({
    required this.title,
    required this.size,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      title: title,
      size: size,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartState {
  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>([]);

  void addItem(CartItem item) {
    final existingIndex = items.value.indexWhere(
      (existing) => existing.title == item.title && existing.size == item.size,
    );

    if (existingIndex != -1) {
      final updated = [...items.value];
      final existing = updated[existingIndex];
      updated[existingIndex] =
          existing.copyWith(quantity: existing.quantity + 1);
      items.value = updated;
    } else {
      items.value = [...items.value, item];
    }
  }

  void incrementQuantity(int index) {
    final updated = [...items.value];
    updated[index] =
        updated[index].copyWith(quantity: updated[index].quantity + 1);
    items.value = updated;
  }

  void decrementQuantity(int index) {
    final updated = [...items.value];
    final current = updated[index];
    final nextQty = current.quantity - 1;

    if (nextQty <= 0) {
      updated.removeAt(index);
    } else {
      updated[index] = current.copyWith(quantity: nextQty);
    }
    items.value = updated;
  }
}

final cartState = CartState();
