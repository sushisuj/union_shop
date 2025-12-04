// ignore_for_file: unused_element, unnecessary_null_comparison, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart'; // For CartItem and cart logic

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ScrollController _scrollController = ScrollController();

  void _openSearchBar() {
    // Your logic to open the search bar
  }

  void _scrollToTopAndOpenSearch() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _openSearchBar();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = cartState.items.value;
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: Column(
        children: [
          UnionNavBar(onSearchIconTap: _openSearchBar),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkout side (left)
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 16 : 32,
                              horizontal: isMobile ? 8 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Express checkout',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: isMobile ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: isMobile ? 38 : 48,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF6C3DFF),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                isMobile ? 8 : 12),
                                          ),
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 12 : 18,
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text('Crypto'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: isMobile ? 8 : 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: isMobile ? 38 : 48,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                isMobile ? 8 : 12),
                                          ),
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 12 : 18,
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: const Text('PayPal'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              Row(
                                children: [
                                  Expanded(child: Divider(thickness: 1)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 6 : 12),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: isMobile ? 13 : 16),
                                    ),
                                  ),
                                  Expanded(child: Divider(thickness: 1)),
                                ],
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              // Credit Card Input Fields
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Input Card Details',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: isMobile ? 15 : 18,
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 8 : 12),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Cardholder Name',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: isMobile ? 10 : 14),
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 8 : 12),
                                  TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Card Number',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: isMobile ? 10 : 14),
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 8 : 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Expiry Date (MM/YY)',
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical:
                                                        isMobile ? 10 : 14),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: isMobile ? 8 : 12),
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'CVV',
                                            border: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical:
                                                        isMobile ? 10 : 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: isMobile ? 8 : 12),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Billing Address',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: isMobile ? 10 : 14),
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 8 : 12),
                                  // New: Basic Address Field
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Delivery Address',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: isMobile ? 10 : 14),
                                    ),
                                    maxLines: isMobile ? 2 : 3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Summary side (right)
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 16 : 32,
                              horizontal: isMobile ? 8 : 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                  height: isMobile ? 40 : 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              ...cartItems.map((item) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: isMobile ? 10 : 16),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: isMobile ? 14 : 16,
                                                ),
                                              ),
                                              if (item.size != null)
                                                Text(
                                                  item.size!,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        isMobile ? 12 : 14,
                                                  ),
                                                ),
                                              if (item.message != null &&
                                                  item.message!.isNotEmpty)
                                                Text(
                                                  item.message!,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        isMobile ? 12 : 14,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              item.price,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: isMobile ? 13 : 15,
                                              ),
                                            ),
                                            if (item.quantity > 1)
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: isMobile ? 2 : 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple[50],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  'x${item.quantity}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        isMobile ? 11 : 13,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: isMobile ? 16 : 24),
                              Text(
                                'Discount codes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 14 : 16,
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter discount code',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(4)),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: isMobile ? 10 : 14),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: isMobile ? 38 : 48,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4d2963),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(4)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: isMobile ? 12 : 24),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                          fontSize: isMobile ? 13 : 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 20 : 32),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('Subtotal',
                                        style: TextStyle(
                                            fontSize: isMobile ? 13 : 16)),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '£${cartItems.fold<double>(0, (sum, item) => sum + (double.tryParse(item.price.replaceAll('£', '')) ?? 0) * item.quantity).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: isMobile ? 13 : 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 8 : 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('Shipping',
                                        style: TextStyle(
                                            fontSize: isMobile ? 13 : 16)),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('n/a',
                                          style: TextStyle(
                                              fontSize: isMobile ? 13 : 16,
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 18 : 22)),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '£${cartItems.fold<double>(0, (sum, item) => sum + (double.tryParse(item.price.replaceAll('£', '')) ?? 0) * item.quantity).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: isMobile ? 18 : 22),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              SizedBox(
                                width: double.infinity,
                                height: isMobile ? 38 : 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4d2963),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isMobile ? 15 : 18),
                                  ),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                        content: Row(
                                          children: const [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                  'Processing Order, Hold on for a moment'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    await Future.delayed(
                                        const Duration(seconds: 3));
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(
                                        context,
                                        '/order-summary',
                                        arguments: {'cardEnding': '1234'},
                                      );
                                    }
                                  },
                                  child: const Text('Place Order'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Footer removed from checkout page
        ],
      ),
    );
  }
}
