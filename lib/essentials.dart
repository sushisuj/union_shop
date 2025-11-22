// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors
import 'package:flutter/material.dart';

class EssentialsPage extends StatelessWidget {
  const EssentialsPage({super.key});

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
                      // Products
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 2 : 1,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 48,
                          childAspectRatio: 2.5,
                          children: const [
                            ProductCard(
                              title: 'Essential Grey Hoodie Mens',
                              price: '£29.99',
                              imageUrl: 'assets/grey_hoodie.png',
                            ),
                            ProductCard(
                              title: 'Essential Grey Hoodie Womens',
                              price: '£29.99',
                              imageUrl: 'assets/grey_hoodie_woman.png',
                            ),
                          ],
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                // Product price
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
