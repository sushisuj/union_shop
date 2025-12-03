import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart';

class OrderSummaryPage extends StatelessWidget {
  final String cardEnding;
  const OrderSummaryPage({Key? key, required this.cardEnding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItems = cartState.items.value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UnionNavBar(onSearchIconTap: () {}),
            const SizedBox(height: 32),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order successfully placed',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...cartItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  item.size,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                if (item.message != null &&
                                    item.message!.isNotEmpty)
                                  Text(
                                    item.message!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item.price,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                if (item.quantity > 1)
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'x${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 32),
                  Text(
                    'Paid with card $cardEnding',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Grand Total Calculation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Grand Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '£${cartItems.fold<double>(0, (sum, item) => sum + (double.tryParse(item.price.replaceAll('£', '')) ?? 0) * item.quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Not done Shopping?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: 220,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4d2963),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              cartState.items.value = [];
                              Navigator.pushNamed(context, '/');
                            },
                            child: const Text('Continue Shopping'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// End of file
