import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart';

class PersonalisationPage extends StatefulWidget {
  const PersonalisationPage({super.key});

  @override
  State<PersonalisationPage> createState() => _PersonalisationPageState();
}

class _PersonalisationPageState extends State<PersonalisationPage> {
  final List<String> _sizes = ['One Line of Text', 'Two Lines of Text'];
  String _selectedSize = 'One Line of Text';
  String _confirmationMessage = '';

  String get _currentPrice =>
      _selectedSize == 'Two Lines of Text' ? '£5.00' : '£3.00';

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final product = args is PrintShackProduct
        ? args
        : const PrintShackProduct(
            title: 'Personalisation',
            price: '£3.00',
            imageUrl: 'assets/personalisation.png',
            description: '''
Add your own text or design to make it uniquely yours!

One line of text is 10 characters.

Please ensure all spellings are correct before submitting your purchase as we will print your item with the exact wording you provide. We will not be responsible for any incorrect spellings printed onto your garment. Personalised items do not qualify for refunds.
''',
          );

    // ensure selected size is valid for this product (if product provides sizes)
    if (product.sizes.isNotEmpty && !product.sizes.contains(_selectedSize)) {
      _selectedSize = product.sizes.first;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UnionNavBar(), // navbar on every product page

            // Product details
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image unavailable',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Product name
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Product price
                  Text(
                    _currentPrice,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4d2963),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Size selector
                  Row(
                    children: [
                      const Text(
                        'Lines:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedSize,
                        items: _sizes
                            .map(
                              (size) => DropdownMenuItem<String>(
                                value: size,
                                child: Text(size),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => _selectedSize = value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Custom message input
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Your custom message',
                      hintText: _selectedSize == 'Two Lines of Text'
                          ? 'Enter up to 2 lines (max 10 chars per line)'
                          : 'Enter up to 10 characters',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLength: _selectedSize == 'Two Lines of Text' ? 21 : 10,
                    maxLines: _selectedSize == 'Two Lines of Text' ? 2 : 1,
                    onChanged: (value) {
                      // You can store this value in a variable if needed
                    },
                  ),

                  const SizedBox(height: 24),

                  // Product description
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Confirmation message (appears above Add to cart button)
                  if (_confirmationMessage.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 14,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _confirmationMessage,
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E9F45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmationMessage =
                              "'${product.title}' in size '$_selectedSize' has been added to cart!";
                        });
                        cartState.addItem(
                          CartItem(
                            title: product.title,
                            size: _selectedSize,
                            price: _currentPrice,
                          ),
                        );
                      },
                      child: const Text(
                        'Add to cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: const Text(
                'Placeholder Footer',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrintShackProduct {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final List<String> sizes;

  const PrintShackProduct({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.sizes = const [], // default: no size choices
  });
}
