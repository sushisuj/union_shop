// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart'; // new

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const UnionNavBar(), // replaces the old header + navbar
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
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
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 2 : 1,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 32,
                    children: collections.map((item) {
                      return GestureDetector(
                        onTap: () {
                          if (item.title == 'Essentials') {
                            Navigator.pushNamed(context, '/essentials');
                          } else if (item.title == 'Sale') {
                            Navigator.pushNamed(context, '/sale');
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
              ],
            ),
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
                    Text('Mon-Fri: 9am - 5pm',
                        style: TextStyle(color: Colors.grey)),
                    Text('Sat: 10am - 4pm',
                        style: TextStyle(color: Colors.grey)),
                    Text('Sun: Closed', style: TextStyle(color: Colors.grey)),
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
