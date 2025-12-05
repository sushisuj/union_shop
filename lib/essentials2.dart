import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/essentials.dart';
import 'package:union_shop/product_page.dart';

class EssentialsPage2 extends StatefulWidget {
  const EssentialsPage2({super.key});

  @override
  State<EssentialsPage2> createState() => _EssentialsPage2State();
}

class _EssentialsPage2State extends State<EssentialsPage2> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();
  bool _showSearchBar = false;

  final List<_Product> _products = [
    _Product(
      title: 'Sandwich',
      price: '£1.99',
      imageUrl: 'assets/veg.png',
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
                            'Merchandise',
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
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final width = MediaQuery.of(context).size.width;
                        final bool isDesktop = width >= 1024;
                        final bool isTablet = width >= 600 && width < 1024;
                        final crossAxisCount =
                            isDesktop ? 3 : (isTablet ? 2 : 1);
                        final childAspectRatio =
                            isDesktop ? 1.55 : (isTablet ? 0.7 : 1.2);
                        final products = _filteredProducts;
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
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              title: product.title,
                              price: product.price,
                              imageUrl: product.imageUrl,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductPage(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:
                              const Icon(Icons.arrow_left, color: Colors.grey),
                        ),
                        const SizedBox(width: 32),
                        const Text(
                          'Page 2 of 2',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        const SizedBox(width: 32),
                        OutlinedButton(
                          onPressed: null, // No next page on page 2
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:
                              const Icon(Icons.arrow_right, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  FooterWidget(onSearchTap: () {}),
                ],
              ),
            ),
          );
        },
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
