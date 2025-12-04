// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_local_variable
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/product_page.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({super.key});

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  // Map of product titles to ProductDetails for navigation
  final Map<String, ProductDetails> _productDetailsMap = {
    'Essential Grey Hoodie Mens': ProductDetails(
      title: 'Essential Grey Hoodie Mens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie.png',
      description: 'A classic grey hoodie for men.',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    'Essential Grey Hoodie Womens': ProductDetails(
      title: 'Essential Grey Hoodie Womens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie_woman.png',
      description: 'A classic grey hoodie for women.',
      sizes: ['XS', 'S', 'M', 'L', 'XL'],
    ),
    'Lanyard Card Holder': ProductDetails(
      title: 'Lanyard Card Holder',
      price: '£2.99',
      imageUrl: 'assets/merchandise.png',
      description: 'Keep your cards safe and handy.',
      sizes: ['One Size'],
    ),
    'Essential USB-C Charger': ProductDetails(
      title: 'Essential USB-C Charger',
      price: '£6.99',
      imageUrl: 'assets/charger.png',
      description: 'Fast charging USB-C charger.',
      sizes: ['One Size'],
    ),
  };
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();
  bool _showSearchBar = false;

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

  void _openSearchBar() {
    setState(() {
      _showSearchBar = true;
    });
  }

  void _closeSearchBar() {
    setState(() {
      _showSearchBar = false;
    });
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Navbar
                  UnionNavBar(onSearchIconTap: _openSearchBar),
                  if (_showSearchBar)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search the entire shop...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: _closeSearchBar,
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
                                ? 0.7
                                : 0.35); // minimum aspect ratio for mobile

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
                              onTap: () {
                                if (_productDetailsMap
                                    .containsKey(product.title)) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                        initialProduct:
                                            _productDetailsMap[product.title]!,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
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

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1024;
    final bool isTablet = width >= 600 && width < 1024;

    final double imageHeight = isDesktop
        ? 190 // slightly reduced for desktop
        : (isTablet ? 160 : 130); // reduced for tablet/mobile
    final EdgeInsets contentPadding = EdgeInsets.symmetric(
      horizontal: 16,
      vertical: isDesktop ? 20 : (isTablet ? 16 : 10),
    );

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: isDesktop ? 220 : (isTablet ? 160 : 120),
        ),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: SizedBox(
                  height: isDesktop ? 90 : (isTablet ? 60 : 40),
                  width: double.infinity,
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: isDesktop ? 10 : (isTablet ? 6 : 4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isDesktop ? 13 : (isTablet ? 11 : 9),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: isDesktop ? 12 : (isTablet ? 10 : 8),
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
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
  final String imageUrl;
  final String category;

  _Product({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
