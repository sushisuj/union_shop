import 'package:flutter/material.dart';
import 'package:union_shop/cart_state.dart';

class CartIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color iconColor;

  const CartIconButton({
    super.key,
    required this.onPressed,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CartItem>>(
      valueListenable: cartState.items,
      builder: (_, items, __) {
        final count =
            items.fold<int>(0, (total, item) => total + item.quantity);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 18,
                color: iconColor,
              ),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: onPressed,
            ),
            if (count > 0)
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
