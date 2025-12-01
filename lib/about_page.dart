import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _UnionNavBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'About us',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome to the Union Shop!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          'We’re dedicated to giving you the very best University branded products, with a range of clothing and merchandise available to shop all year round! We even offer an exclusive ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/print-shack'),
                        child: const Text(
                          'personalisation service!',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'All online purchases are available for delivery or instore collection!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don’t hesitate to contact us at hello@upsu.net.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Happy shopping!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The Union Shop & Reception Team',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnionNavBar extends StatelessWidget {
  const _UnionNavBar();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: const Color(0xFF4d2963),
          child: const Text(
            'Student Saver Weekend – Free Click & Collect on orders over £30',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Container(
          height: 72,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (_) => false,
                ),
                child: Image.network(
                  'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                  height: 26,
                ),
              ),
              const Spacer(),
              if (isMobile)
                PopupMenuButton<String>(
                  tooltip: 'Menu',
                  onSelected: (value) {
                    switch (value) {
                      case 'home':
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        break;
                      case 'shop':
                        Navigator.pushNamed(context, '/collections');
                        break;
                      case 'about':
                        Navigator.pushNamed(context, '/about');
                        break;
                    }
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Menu',
                        style: TextStyle(
                          color: Color(0xFF4d2963),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Color(0xFF4d2963)),
                    ],
                  ),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'home', child: Text('Home')),
                    PopupMenuItem(value: 'shop', child: Text('Shop')),
                    PopupMenuItem(value: 'about', child: Text('About Us')),
                  ],
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NavLink(
                      label: 'Home',
                      onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (_) => false,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const _ShopDropdown(),
                    const SizedBox(width: 20),
                    _NavLink(
                      label: 'About Us',
                      onTap: () => Navigator.pushNamed(context, '/about'),
                    ),
                  ],
                ),
              const SizedBox(width: 24),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.grey),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person_outline, color: Colors.grey),
                onPressed: () => Navigator.pushNamed(context, '/login'),
              ),
              IconButton(
                icon:
                    const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4d2963),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _ShopDropdown extends StatefulWidget {
  const _ShopDropdown();

  @override
  State<_ShopDropdown> createState() => _ShopDropdownState();
}

class _ShopDropdownState extends State<_ShopDropdown> {
  final List<String> options = [
    'Essentials',
    'Sale',
    'Merchandise',
    'Winter',
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'Essentials':
            Navigator.pushNamed(context, '/essentials');
            break;
          case 'Sale':
            Navigator.pushNamed(context, '/sale');
            break;
          case 'Merchandise':
            Navigator.pushNamed(context, '/collections');
            break;
          case 'Winter':
            // TODO: add winter route when available
            break;
        }
      },
      child: const Text(
        'Shop',
        style: TextStyle(
          color: Color(0xFF4d2963),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
      itemBuilder: (_) => options
          .map((option) => PopupMenuItem(value: option, child: Text(option)))
          .toList(),
    );
  }
}
