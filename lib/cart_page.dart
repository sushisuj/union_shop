import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const UnionNavBar(),
          Expanded(
            child: ValueListenableBuilder<List<CartItem>>(
              valueListenable: cartState.items,
              builder: (context, items, _) {
                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      'Your cart is empty',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text('Size: ${item.size}'),
                      trailing: Text(item.price),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
