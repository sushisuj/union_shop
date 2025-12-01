// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/shop_search_bar.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
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

  final List<_CollectionItem> collections = const [
    _CollectionItem(
      title: 'Essentials',
      image: 'assets/essentials.png',
    ),
    _CollectionItem(
      title: 'Winter Collection',
      image: 'assets/winter.png',
    ),
    _CollectionItem(
      title: 'Merchandise',
      image: 'assets/merchandise.png',
    ),
    _CollectionItem(
      title: 'Personalisation',
      image: 'assets/personalisation.png',
    ),
    _CollectionItem(
      title: 'Sale',
      image: 'assets/sale.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Collections',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                crossAxisSpacing: 24,
                mainAxisSpacing: 32,
                children: collections.map((item) {
                  return GestureDetector(
                    onTap: () {
                      if (item.title == 'Essentials') {
                        Navigator.pushNamed(context, '/essentials');
                      } else if (item.title == 'Sale') {
                        Navigator.pushNamed(context, '/sale');
                      } else if (item.title == 'Personalisation') {
                        Navigator.pushNamed(context, '/print-shack');
                      }
                      // Add more navigation logic for other collections if needed
                    },
                    child: Stack(
                      children: [
                        // Background image with opacity
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.cover,
                              color: Colors.black.withOpacity(0.7),
                              colorBlendMode: BlendMode.darken,
                            ),
                          ),
                        ),
                        // Overlay text
                        Center(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
            FooterWidget(onSearchTap: _scrollToTopAndOpenSearch),
          ],
        ),
      ),
    );
  }
}

class _CollectionItem {
  final String title;
  final String image;
  const _CollectionItem({required this.title, required this.image});
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
