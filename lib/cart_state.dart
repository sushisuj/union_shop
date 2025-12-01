import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String size;
  final String price;
  final int quantity;
  final String? message; // <-- Add this line

  const CartItem({
    required this.title,
    required this.size,
    required this.price,
    this.quantity = 1,
    this.message, // <-- Add this line
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      title: title,
      size: size,
      price: price,
      quantity: quantity ?? this.quantity,
      message: message, // <-- Add this line
    );
  }
}

class CartState {
  final ValueNotifier<List<CartItem>> items = ValueNotifier<List<CartItem>>([]);

  void addItem(CartItem item) {
    final existingIndex = items.value.indexWhere(
      (i) =>
          i.title == item.title &&
          i.size == item.size &&
          i.price == item.price &&
          (i.message ?? '') == (item.message ?? ''),
    );

    if (existingIndex != -1) {
      // If all fields (including message) match, increment quantity
      final updated = [...items.value];
      updated[existingIndex] = updated[existingIndex]
          .copyWith(quantity: updated[existingIndex].quantity + 1);
      items.value = updated;
    } else {
      // Otherwise, add as a new cart item
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
