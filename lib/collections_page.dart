// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  final List<_CollectionItem> collections = const [
    _CollectionItem(
      title: 'Essentials',
      image: 'assets/essentials.jpg',
    ),
    _CollectionItem(
      title: 'Winter Collection',
      image: 'assets/winter.jpg',
    ),
    _CollectionItem(
      title: 'Merchandise',
      image: 'assets/merchandise.jpg',
    ),
    _CollectionItem(
      title: 'Personalisation',
      image: 'assets/personalisation.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          context, '/', (route) => false);
                    }),
                _NavTab(title: 'Shop', onTap: () {}),
                _NavTab(
                    title: 'About Us',
                    onTap: () {
                      Navigator.pushNamed(context, '/about');
                    }),
              ],
            ),
          ),
          // Collections Title
          const SizedBox(height: 32),
          const Text(
            'Collections',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 32),
          // Collection boxes
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 32,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: collections.map((item) {
                return GestureDetector(
                  onTap: () {
                    // TODO: Add navigation logic for each collection
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
          // Footer (copy from your main file)
          Container(
            width: double.infinity,
            color: Colors.grey[50],
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opening Times (Left)
                // ignore: prefer_const_constructors
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
                Expanded(child: Container()),
                // Help and Information (Right)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Help and Information',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Search',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    Text('Terms and Conditions',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    Text('Contact Us',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                    Text('FAQ',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
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
