import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/essentials.dart';

class EssentialsPage2 extends StatefulWidget {
  const EssentialsPage2({super.key});

  @override
  State<EssentialsPage2> createState() => _EssentialsPage2State();
}

class _EssentialsPage2State extends State<EssentialsPage2> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  bool _showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const UnionNavBar(),
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
                    onPressed: () {
                      setState(() {
                        _showSearchBar = false;
                      });
                    },
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
                      setState(() {
                        // Update search query
                      });
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
                  items: <String>['All', 'Jumpers', 'Tee', 'Merchandise']
                      .map<DropdownMenuItem<String>>((String value) {
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
          // Single product card in a GridView for consistent sizing
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = MediaQuery.of(context).size.width;
                final bool isDesktop = width >= 1024;
                final bool isTablet = width >= 600 && width < 1024;
                final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
                final childAspectRatio =
                    isDesktop ? 1.55 : (isTablet ? 0.7 : 0.35);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: 'Essential Grey Hoodie Mens',
                      price: '£29.99',
                      imageUrl: 'assets/grey_hoodie.png',
                      onTap: () {
                        // You can add navigation to ProductPage here if desired
                      },
                    );
                  },
                );
              },
            ),
          ),
          // Large space for future product content
          const Expanded(
            child: SizedBox(),
          ),
          // Pagination navigation (always visible above footer)
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
                  child: const Icon(Icons.arrow_left, color: Colors.grey),
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
                  child: const Icon(Icons.arrow_right, color: Colors.grey),
                ),
              ],
            ),
          ),
          FooterWidget(onSearchTap: () {}),
        ],
      ),
    );
  }
}
