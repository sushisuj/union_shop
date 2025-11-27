import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String size;
  final String price;

  const CartItem({
    required this.title,
    required this.size,
    required this.price,
  });
}

class CartState {
  final ValueNotifier<List<CartItem>> items = ValueNotifier(const []);

  void addItem(CartItem item) {
    items.value = [...items.value, item];
  }
}

final cartState = CartState();