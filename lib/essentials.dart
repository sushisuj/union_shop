import 'package:flutter/material.dart';

class EssentialsPage extends StatelessWidget {
  const EssentialsPage({super.key});

  // You can keep the same collections or change them for essentials-specific content
  // For now, let's copy the same structure as collections_page.dart

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Main content (everything except footer)
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
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
                      _NavTab(title: 'Shop', onTap: () {
                        Navigator.pushNamed(context, '/collections');
                      }),
                      _NavTab(
                          title: 'About Us',
                          onTap: () {
                            Navigator.pushNamed(context, '/about');
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    'Essentials',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // You can copy the grid or change it for essentials-specific items
                // For now, let's just show the essentials image as a placeholder
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Image.asset(
                    'assets/essentials.png',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
          // Footer (copy exactly as in collections_page.dart)
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

// Add below your EssentialsPage class

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
        onTap: () {},
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