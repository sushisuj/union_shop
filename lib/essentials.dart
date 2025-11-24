// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({super.key});

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<_Product> _products = [
    _Product(
      title: 'Essential Grey Hoodie Mens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie.png',
      category: 'Jumpers',
    ),
    _Product(
      title: 'Essential Grey Hoodie Womens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie_woman.png',
      category: 'Jumpers',
    ),
    _Product(
      title: 'Essential White T-Shirt Mens',
      price: '£12.99',
      imageUrl: 'assets/essentials.png',
      category: 'Tee',
    ),
    _Product(
      title: 'Essential White T-Shirt Womens',
      price: '£12.99',
      imageUrl: 'assets/essentials2.png',
      category: 'Tee',
    ),
    _Product(
      title: 'Lanyard Card Holder',
      price: '£2.99',
      imageUrl: 'assets/merchandise.png',
      category: 'Merchandise',
    ),
    _Product(
      title: 'Essential USB-C Charger',
      price: '£6.99',
      imageUrl: 'assets/charger.png',
      category: 'Merchandise',
    ),
  ];

  List<_Product> get _filteredProducts {
    final query = _searchController.text.toLowerCase();
    return _products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesQuery = product.title.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
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
                          'Our Biggest Sale of the Year is Here! Up to 50% Off Selected Items. Shop Now!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Navbar
                      Container(
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _NavTab(
                              title: 'Home',
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false,
                                );
                              },
                            ),
                            _NavTab(title: 'Shop', onTap: () {}),
                            _NavTab(
                              title: 'About Us',
                              onTap: () {
                                Navigator.pushNamed(context, '/about');
                              },
                            ),
                          ],
                        ),
                      ),
                      // Search and Filter
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search products...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            DropdownButton<String>(
                              value: _selectedCategory,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                              items: <String>[
                                'All',
                                'Jumpers',
                                'Tee',
                                'Merchandise'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                        child: Builder(
                          builder: (context) {
                            final width = MediaQuery.of(context).size.width;
                            final bool isDesktop = width >= 1024;
                            final bool isTablet = width >= 600 && width < 1024;

                            final crossAxisCount =
                                isDesktop ? 3 : (isTablet ? 2 : 1);
                            final childAspectRatio = isDesktop
                                ? 1.55 // prevents 27px overflow on desktop
                                : (isTablet
                                    ? 1.25
                                    : 0.9); // prevents 43px overflow on mobile

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
                                  imageUrl: product.imageUrl,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  // Footer
                  Container(
                    width: double.infinity,
                    color: Colors.grey[50],
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Opening Times (Left)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Opening Times',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Mon-Fri: 9am - 5pm',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Sat: 10am - 4pm',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Sun: Closed',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        // Help and Information (Right)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Help and Information',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _FooterLink(text: 'Search'),
                            _FooterLink(text: 'Terms and Conditions'),
                            _FooterLink(text: 'Contact Us'),
                            _FooterLink(text: 'FAQ'),
                          ],
                        ),
                      ],
                    ),
                  ),
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
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 600 && width < 1024;

    final double imageHeight = isDesktop
        ? 200 // down from 220 to remove the last 21px overflow
        : (isTablet ? 190 : 160);
    final EdgeInsets contentPadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: isDesktop ? 28 : (isTablet ? 24 : 18),
    );

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: Image.asset(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: contentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Product {
  final String title;
  final String price;
  final String imageUrl;
  final String category;

  _Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
