// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/essentials.dart';
import 'package:union_shop/login_page.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/cart_page.dart';
import 'package:union_shop/printshack_page.dart';
import 'package:union_shop/widgets/cart_icon_button.dart';

// test commit
void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {
        '/product': (context) => const ProductPage(),
        '/print-shack': (context) => const PersonalisationPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/essentials': (context) => const EssentialsPage(),
        '/login': (context) => const LoginPage(),
        '/sale': (context) => const SalePage(),
        '/cart': (context) => CartPage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _globalSearchController = TextEditingController();
  final FocusNode _globalSearchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final LayerLink _searchFieldLink = LayerLink();
  final GlobalKey _searchFieldKey = GlobalKey();
  OverlayEntry? _searchOverlay;

  bool _showGlobalSearch = false;
  List<ProductDetails> _filtered = const [];

  static const List<ProductDetails> _allProducts = [
    ProductDetails(
      title: 'Essential Grey Hoodie Mens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie.png',
      description: 'Premium brushed cotton hoodie with kangaroo pocket.',
    ),
    ProductDetails(
      title: 'Essential Grey Hoodie Womens',
      price: '£29.99',
      imageUrl: 'assets/grey_hoodie_woman.png',
      description: 'Tailored women’s fit with soft fleece lining.',
    ),
    ProductDetails(
      title: 'Black Baseball Cap',
      price: '£7.99',
      imageUrl: 'assets/black_cap.png',
      description: 'Adjustable cotton cap with embroidered Union logo.',
    ),
    ProductDetails(
      title: 'Hydroflask with straw',
      price: '£11.99',
      imageUrl: 'assets/jug.jpg',
      description: 'Insulated stainless bottle with flip straw lid.',
    ),
    ProductDetails(
      title: 'Lanyard Card Holder',
      price: '£2.99',
      imageUrl: 'assets/merchandise.png',
      description: 'Durable PVC holder plus purple lanyard.',
    ),
    ProductDetails(
      title: 'Essential USB-C Charger',
      price: '£6.99',
      imageUrl: 'assets/charger.png',
      description: 'Fast-charge USB-C cable for phones and tablets.',
    ),
    ProductDetails(
      title: 'Essential White T-Shirt Mens',
      price: '£12.99',
      imageUrl: 'assets/essentials.png',
      description: 'Classic crew neck tee in breathable cotton.',
    ),
    ProductDetails(
      title: 'Essential White T-Shirt Womens',
      price: '£12.99',
      imageUrl: 'assets/essentials2.png',
      description: 'Slim-fit cotton tee with embroidered crest.',
    ),
    ProductDetails(
      title: 'Sunglasses',
      price: '£10.99',
      imageUrl: 'assets/sunglasses.png',
      description: 'Sale sunglasses with UV400 protection.',
    ),
    ProductDetails(
      title: 'Scientific Calculator',
      price: '£9.99',
      imageUrl: 'assets/calc.png',
      description: 'Scientific calculator now at sale price.',
    ),
    ProductDetails(
      title: 'Fleece Jacket Mens',
      price: '£39.99',
      imageUrl: 'assets/jumper1.png',
      description: 'Sale fleece jacket with thermal lining.',
    ),
    ProductDetails(
      title: 'Fleece Jacket Womens',
      price: '£39.99',
      imageUrl: 'assets/jumper2.png',
      description: 'Women’s sale fleece with tapered fit.',
    ),
  ];

  void _onSearchChanged(String query) {
    final q = query.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? const []
          : _allProducts
              .where((p) =>
                  p.title.toLowerCase().contains(q) ||
                  p.description.toLowerCase().contains(q))
              .toList();
    });
    _refreshSearchOverlay();
  }

  void _refreshSearchOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_showGlobalSearch || _filtered.isEmpty) {
        _removeSearchOverlay();
        return;
      }

      _removeSearchOverlay();

      final renderBox =
          _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      _searchOverlay = OverlayEntry(
        builder: (_) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 6,
          width: size.width,
          child: Material(
            color: Colors.white,
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 6),
                shrinkWrap: true,
                itemCount: _filtered.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, thickness: 0.4),
                itemBuilder: (context, index) {
                  final product = _filtered[index];
                  return ListTile(
                    dense: true,
                    title: Text(product.title,
                        style: const TextStyle(fontSize: 14)),
                    subtitle: Text(product.price),
                    onTap: () => _selectProduct(product),
                  );
                },
              ),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(_searchOverlay!);
    });
  }

  void _removeSearchOverlay() {
    _searchOverlay?.remove();
    _searchOverlay = null;
  }

  void _selectProduct(ProductDetails product) {
    Navigator.pushNamed(context, '/product', arguments: product);
    setState(() {
      _globalSearchController.clear();
      _filtered = const [];
      _showGlobalSearch = false;
    });
    _removeSearchOverlay();
  }

  Future<void> _openSearchAndScrollToTop() async {
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    if (!_showGlobalSearch) {
      setState(() => _showGlobalSearch = true);
    }
    _globalSearchFocusNode.requestFocus();
    _refreshSearchOverlay();
  }

  void _closeSearch() {
    setState(() {
      _globalSearchController.clear();
      _filtered = const [];
      _showGlobalSearch = false;
    });
    _globalSearchFocusNode.unfocus();
    _removeSearchOverlay();
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    _globalSearchController.dispose();
    _globalSearchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
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
                  // Main header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        // Logo
                        GestureDetector(
                          onTap: () {
                            navigateToHome(context);
                          },
                          child: Image.network(
                            'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                            height: 18,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                width: 18,
                                height: 18,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        // Centered navigation tabs
                        if (isMobile)
                          PopupMenuButton<String>(
                            tooltip: 'Menu',
                            onSelected: (value) {
                              switch (value) {
                                case 'home':
                                  navigateToHome(context);
                                  break;
                                case 'shop':
                                  Navigator.pushNamed(context, '/collections');
                                  break;
                                case 'print':
                                  Navigator.pushNamed(context, '/print-shack');
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
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down,
                                    color: Colors.deepPurple),
                              ],
                            ),
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'home', child: Text('Home')),
                              PopupMenuItem(value: 'shop', child: Text('Shop')),
                              PopupMenuItem(
                                  value: 'print', child: Text('Print Shack')),
                              PopupMenuItem(
                                  value: 'about', child: Text('About Us')),
                            ],
                          )
                        else
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => navigateToHome(context),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              _ShopDropdown(),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, '/print-shack'),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Print Shack',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/about'),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'About Us',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const Spacer(),
                        // Icons (search, person, bag, menu)
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              SizedBox(
                                width: isMobile ? 180 : 260,
                                child: CompositedTransformTarget(
                                  link: _searchFieldLink,
                                  child: AnimatedContainer(
                                    key: _searchFieldKey,
                                    duration: const Duration(milliseconds: 200),
                                    height: 36,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _showGlobalSearch ? 12 : 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _showGlobalSearch
                                          ? Colors.grey[100]
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(18),
                                      boxShadow: _showGlobalSearch
                                          ? const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                offset: Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: _showGlobalSearch
                                        ? TextField(
                                            controller: _globalSearchController,
                                            focusNode: _globalSearchFocusNode,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  'Search the entire shop…',
                                              border: InputBorder.none,
                                            ),
                                            onChanged: _onSearchChanged,
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _showGlobalSearch
                                      ? Icons.close
                                      : Icons.search,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(
                                    minWidth: 32, minHeight: 32),
                                onPressed: () {
                                  if (_showGlobalSearch) {
                                    _closeSearch();
                                  } else {
                                    setState(() => _showGlobalSearch = true);
                                    _globalSearchFocusNode.requestFocus();
                                    _refreshSearchOverlay();
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.person_outline,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              ),
                              CartIconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                              ),
                              if (isMobile)
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.menu,
                                      size: 20, color: Colors.grey),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 'search':
                                        setState(
                                            () => _showGlobalSearch = true);
                                        _globalSearchFocusNode.requestFocus();
                                        _refreshSearchOverlay();
                                        break;
                                      case 'login':
                                        Navigator.pushNamed(context, '/login');
                                        break;
                                      case 'cart':
                                        Navigator.pushNamed(context, '/cart');
                                        break;
                                    }
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                        value: 'search', child: Text('Search')),
                                    PopupMenuItem(
                                        value: 'login', child: Text('Account')),
                                    PopupMenuItem(
                                        value: 'cart', child: Text('Cart')),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Hero Section
            const _HeroCarousel(),

            // Products Section
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'Featured Products',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
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
                        ProductCard(
                          title: 'Black Baseball Cap',
                          price: '£7.99',
                          imageUrl: 'assets/black_cap.png',
                        ),
                        ProductCard(
                          title: 'Hydroflask with straw',
                          price: '£11.99',
                          imageUrl: 'assets/jug.jpg',
                        ),
                        ProductCard(
                          title: 'Lanyard Card Holder',
                          price: '£2.99',
                          imageUrl: 'assets/merchandise.png',
                        ),
                        ProductCard(
                          title: 'Essential USB-C Charger',
                          price: '£6.99',
                          imageUrl: 'assets/charger.png',
                        ),
                      ],
                    ),
                  ],
                ),
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

                  // Add here, before Expanded(child: Container())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Latest Offers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 400,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Email address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(4)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF4d2963),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(4)),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                ),
                                onPressed: () {
                                  // TODO: handle subscribe action
                                },
                                child: const Text(
                                  'SUBSCRIBE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
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
                      _FooterLink(
                        text: 'Search',
                        onTap: _openSearchAndScrollToTop,
                      ),
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
    final isNarrow = MediaQuery.of(context).size.width < 600;
    final double imageHeight = isNarrow ? 220 : 600;
    final double textSpacing = isNarrow ? 8 : 4;

    Widget imageWidget;
    if (title == 'Essential Grey Hoodie Mens' ||
        title == 'Essential Grey Hoodie Womens') {
      imageWidget = SizedBox(
        height: imageHeight,
        width: double.infinity,
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _placeholderImage(),
        ),
      );
    } else {
      imageWidget = SizedBox(
        height: imageHeight,
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _placeholderImage(),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (title == 'Essential Grey Hoodie Mens') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Essential Grey Hoodie Mens',
              price: '£29.99',
              imageUrl: 'assets/grey_hoodie.png',
              description:
                  'Premium brushed cotton hoodie with kangaroo pocket and embroidered Union crest.',
              sizes: ['XS', 'S', 'M', 'L', 'XL'],
            ),
          );
        } else if (title == 'Essential Grey Hoodie Womens') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Essential Grey Hoodie Womens',
              price: '£29.99',
              imageUrl: 'assets/grey_hoodie_woman.png',
              description:
                  'Tailored fit women’s hoodie with soft fleece lining and embroidered Union crest.',
              sizes: ['XS', 'S', 'M', 'L', 'XL'],
            ),
          );
        } else if (title == 'Black Baseball Cap') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Black Baseball Cap',
              price: '£7.99',
              imageUrl: 'assets/black_cap.png',
              description:
                  'Adjustable cotton cap with embroidered Union logo and breathable eyelets.',
            ),
          );
        } else if (title == 'Hydroflask with straw') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Hydroflask with straw',
              price: '£11.99',
              imageUrl: 'assets/jug.jpg',
              description:
                  'Insulated stainless bottle with flip straw lid—keeps drinks cold for 24h.',
            ),
          );
        } else if (title == 'Lanyard Card Holder') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Lanyard Card Holder',
              price: '£2.99',
              imageUrl: 'assets/merchandise.png',
              description:
                  'Durable PVC holder and purple lanyard combo, perfect for student IDs.',
            ),
          );
        } else if (title == 'Essential USB-C Charger') {
          Navigator.pushNamed(
            context,
            '/product',
            arguments: const ProductDetails(
              title: 'Essential USB-C Charger',
              price: '£6.99',
              imageUrl: 'assets/charger.png',
              description:
                  'Fast-charge USB-C cable compatible with Android, iPad, and laptop power banks.',
            ),
          );
        } else {
          Navigator.pushNamed(context, '/product');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageWidget,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: textSpacing),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              SizedBox(height: textSpacing),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey),
      ),
    );
  }
}

// Add this widget below your HomeScreen class (outside any other class)
class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _FooterLink({required this.text, this.onTap});

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
        onTap: widget.onTap ?? () {},
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

// Add this widget below your _FooterLink class (outside any other class)
class _ShopDropdown extends StatefulWidget {
  @override
  State<_ShopDropdown> createState() => _ShopDropdownState();
}

class _ShopDropdownState extends State<_ShopDropdown> {
  final List<String> options = [
    'Essentials',
    'Sale',
    'Merchandise',
    'Winter',
    // Add more options as needed
  ];

  OverlayEntry? _dropdownOverlay;
  bool _isDropdownOpen = false;

  void _showDropdown(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        child: Material(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/collections'); // <-- Navigates to collections page
                    if (_isDropdownOpen) {
                      _removeDropdown();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_dropdownOverlay!);
    setState(() => _isDropdownOpen = true);
  }

  void _removeDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
    setState(() => _isDropdownOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (!_isDropdownOpen) _showDropdown(context);
      },
      onExit: (_) {
        if (_isDropdownOpen) _removeDropdown();
      },
      child: GestureDetector(
        onTap: () {
          if (_isDropdownOpen) {
            _removeDropdown();
          } else {
            _showDropdown(context);
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, '/collections'); // <-- Navigates to collections page
            if (_isDropdownOpen) {
              _removeDropdown();
            }
          },
          child: Row(
            children: [
              Text(
                'Shop',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
              Icon(
                _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel();

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  final List<Widget> _slides = const [
    _HeroSlide(
      background: NetworkImage(
        'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
      ),
      title: 'Welcome to the Union Shop',
      subtitle: 'Check out all of our collections',
      buttonLabel: 'Browse Products',
      routeName: '/collections',
    ),
    _HeroSlide(
      background: AssetImage('assets/pizza.png'),
      title: 'Fancy some pizza?',
      subtitle: 'Delicious cheese and tomato pizza.',
      buttonLabel: 'Order Now',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleArrowTap(bool forward) {
    final nextPage = forward ? _currentPage + 1 : _currentPage - 1;
    if (nextPage >= 0 && nextPage < _slides.length) {
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: _slides,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              splashRadius: 28,
              iconSize: 32,
              color: Colors.white70,
              onPressed:
                  _currentPage == 0 ? null : () => _handleArrowTap(false),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              splashRadius: 28,
              iconSize: 32,
              color: Colors.white70,
              onPressed: _currentPage == _slides.length - 1
                  ? null
                  : () => _handleArrowTap(true),
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  final ImageProvider background;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final String? routeName;

  const _HeroSlide({
    required this.background,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: background, fit: BoxFit.cover),
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.65)),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          top: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: routeName == null
                    ? () {} // no-op so button appears enabled but does nothing
                    : () => Navigator.pushNamed(context, routeName!),
                child: Text(buttonLabel),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
