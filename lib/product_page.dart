import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/cart_state.dart';
import 'package:union_shop/widgets/footer.dart';

class ProductPage extends StatefulWidget {
  final ProductDetails? initialProduct;

  const ProductPage({super.key, this.initialProduct});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];
  String _selectedSize = 'M';
  String _confirmationMessage = ''; // new: holds confirmation text
  final ScrollController _scrollController = ScrollController();

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  void _openSearchBar() {
    // Your logic to open the search bar (e.g., setState to show it)
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
    final args = ModalRoute.of(context)?.settings.arguments;
    final product = widget.initialProduct ??
        (args is ProductDetails ? args : _placeholderProduct);

    final sizeOptions = LinkedHashSet<String>.from(
      (product.sizes?.isNotEmpty ?? false)
          ? product.sizes!
          : const ['One Size'],
    ).toList();

    if (!sizeOptions.contains(_selectedSize)) {
      _selectedSize = sizeOptions.first;
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
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
                    product.price,
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
                        'Size:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      DropdownButton<String>(
                        value: _selectedSize,
                        items: sizeOptions
                            .map(
                              (size) => DropdownMenuItem<String>(
                                value: size,
                                child: Text(size),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedSize = value);
                          }
                        },
                      ),
                    ],
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
                            price: product.price,
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
            FooterWidget(onSearchTap: _scrollToTopAndOpenSearch),
          ],
        ),
      ),
    );
  }
}

class ProductDetails {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final List<String> sizes;

  const ProductDetails({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.sizes = const [], // default: no size choices
  });
}

final ProductDetails _placeholderProduct = ProductDetails(
  title: 'Placeholder Product',
  price: '\$0.00',
  imageUrl: 'https://via.placeholder.com/300',
  description: 'This is a placeholder product description.',
);
