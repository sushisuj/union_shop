import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const UnionNavBar(),
          Expanded(
            child: Center(
              child: Text(
                'Your cart is empty',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
