// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_element
import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/union_navbar.dart'; // Add this import

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();

  List<_Product> get _filteredProducts {
    final query = _searchController.text.toLowerCase();
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesQuery = product.title.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      // Purple header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        color: const Color(0xFF4d2963),
                        child: const Text(
                          'Sale Picks—Up to 50% Off Selected Items!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Use the shared navbar here
                      UnionNavBar(onSearchIconTap: _openSearchBar),
                      // Search and Filter
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  hintText: 'Search sale items...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            DropdownButton<String>(
                              value: _selectedCategory,
                              onChanged: (newValue) {
                                if (newValue == null) return;
                                setState(() => _selectedCategory = newValue);
                              },
                              items: const [
                                'All',
                                'Jumpers',
                                'Tee',
                                'Merchandise'
                              ].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              underline: Container(
                                height: 2,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Products
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final width = constraints.maxWidth;
                            final bool isDesktop = width >= 1024;
                            final bool isTablet = width >= 600 && width < 1024;

                            final crossAxisCount =
                                isDesktop ? 2 : (isTablet ? 2 : 1);
                            final childAspectRatio = isDesktop
                                ? 2.2
                                : (isTablet ? 1.8 : 0.95); // prevents overflow

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 32,
                                childAspectRatio: childAspectRatio,
                              ),
                              itemCount: _filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];
                                return ProductCard(
                                  title: product.title,
                                  price: product.price,
                                  salePrice: product.salePrice,
                                  imageUrl: product.imageUrl,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/product',
                                      arguments: ProductDetails(
                                        title: product.title,
                                        price:
                                            product.salePrice ?? product.price,
                                        imageUrl: product.imageUrl,
                                        description: product.description,
                                        sizes: product.sizes,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  FooterWidget(onSearchTap: _scrollToTopAndOpenSearch),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const _NavTab({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4d2963),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  const _FooterLink({required this.text});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {}, // Dummy link, does nothing
        child: Text(
          widget.text,
          style: TextStyle(
            color: _isHovering ? Colors.deepPurple : Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? salePrice;
  final String imageUrl;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.onTap,
    this.salePrice,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 600 && width < 1024;

    // Responsive heights and paddings
    final double imageHeight = isDesktop ? 218.0 : (isTablet ? 180.0 : 140.0);
    final double verticalPadding = isDesktop ? 41.0 : (isTablet ? 24.0 : 12.0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Responsive product image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Text block anchored at the bottom
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: verticalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (salePrice != null) ...[
                      Row(
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            salePrice!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Product {
  final String title;
  final String price;
  final String? salePrice;
  final String imageUrl;
  final String category;
  final String description;
  final List<String> sizes;

  const _Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
    this.sizes = const ['One Size'],
    this.salePrice,
  });
}

final List<_Product> _products = [
  _Product(
    title: 'Sunglasses',
    price: '£19.99',
    salePrice: '£10.99',
    imageUrl: 'assets/sunglasses.png',
    category: 'Merchandise',
    description:
        'Protect your eyes in style with UV400 lenses and a lightweight frame.',
  ),
  _Product(
    title: 'Scientific Calculator',
    price: '£15.99',
    salePrice: '£9.99',
    imageUrl: 'assets/calc.png',
    category: 'Merchandise',
    description:
        'Exam-approved scientific calculator packed with trig and stats modes.',
  ),
  _Product(
    title: 'Fleece Jacket Mens',
    price: '£79.99',
    salePrice: '£39.99',
    imageUrl: 'assets/jumper1.png',
    category: 'Jumpers',
    description:
        'Warm men’s fleece with Union crest embroidery and roomy zip pockets.',
    sizes: ['S', 'M', 'L', 'XL'],
  ),
  _Product(
    title: 'Fleece Jacket Womens',
    price: '£79.99',
    salePrice: '£39.99',
    imageUrl: 'assets/jumper2.png',
    category: 'Jumpers',
    description:
        'Tailored women’s fleece featuring soft lining and Union branding.',
    sizes: ['XS', 'S', 'M', 'L'],
  ),
];
