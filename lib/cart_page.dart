import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (sum, item) {
      final numericPrice =
          double.tryParse(item.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
      return sum + numericPrice * item.quantity;
    });
  }

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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Size: ${item.size}\n${item.price} each'),
                          if (item.message != null &&
                              item.message!.trim().isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Message: ${item.message}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => cartState.decrementQuantity(index),
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => cartState.incrementQuantity(index),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ValueListenableBuilder<List<CartItem>>(
            valueListenable: cartState.items,
            builder: (context, items, _) {
              final total = _calculateTotal(items);
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Cart total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '£${total.toStringAsFixed(2)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        // TODO: implement checkout flow
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
