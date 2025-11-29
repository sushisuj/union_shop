import 'package:flutter/material.dart';
import 'package:union_shop/widgets/cart_icon_button.dart';

class UnionNavBar extends StatelessWidget {
  const UnionNavBar({super.key});

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
                      case 'print':
                        Navigator.pushNamed(context, '/print-shack'); // new
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
                    PopupMenuItem(value: 'print', child: Text('Print Shack')),
                    PopupMenuItem(value: 'about', child: Text('About Us')),
                  ],
                )
              else
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _NavLink(label: 'Home', route: '/'),
                    SizedBox(width: 20),
                    _ShopDropdown(),
                    SizedBox(width: 20),
                    _NavLink(
                        label: 'Print Shack', route: '/print-shack'), // new
                    SizedBox(width: 20),
                    _NavLink(label: 'About Us', route: '/about'),
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
              CartIconButton(
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
  final String route;

  const _NavLink({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
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
