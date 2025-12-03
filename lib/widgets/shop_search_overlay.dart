import 'package:flutter/material.dart';
import 'shop_search_bar.dart';
import '../product_page.dart'; // For ProductDetails

class ShopSearchOverlayController {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final BuildContext context;
  bool _showDropdown = false;
  List<ProductDetails> _filtered = [];
  final List<ProductDetails> allProducts;

  ShopSearchOverlayController(
      {required this.context, required this.allProducts});

  void openSearchBar() {
    _showDropdown = true;
    focusNode.requestFocus();
    _insertOverlay();
  }

  void closeSearchBar() {
    controller.clear();
    _filtered = [];
    _showDropdown = false;
    focusNode.unfocus();
    _removeOverlay();
  }

  void onChanged(String query) {
    final q = query.toLowerCase();
    _filtered = q.isEmpty
        ? []
        : allProducts
            .where((p) =>
                p.title.toLowerCase().contains(q) ||
                p.description.toLowerCase().contains(q))
            .toList();
    _insertOverlay();
  }

  void selectProduct(ProductDetails product) {
    Navigator.pushNamed(context, '/product', arguments: product);
    closeSearchBar();
  }

  void _insertOverlay() {
    _removeOverlay();
    if (!_showDropdown || _filtered.isEmpty) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
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
                  title:
                      Text(product.title, style: const TextStyle(fontSize: 14)),
                  subtitle: Text(product.price),
                  onTap: () => selectProduct(product),
                );
              },
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void dispose() {
    controller.dispose();
    focusNode.dispose();
    _removeOverlay();
  }
}

class ShopSearchOverlay extends StatefulWidget {
  final List<ProductDetails> allProducts;
  final Widget child;
  const ShopSearchOverlay(
      {super.key, required this.allProducts, required this.child});

  @override
  State<ShopSearchOverlay> createState() => _ShopSearchOverlayState();
}

class _ShopSearchOverlayState extends State<ShopSearchOverlay> {
  late ShopSearchOverlayController _controller;
  bool _showSearchBar = false;

  @override
  void initState() {
    super.initState();
    _controller = ShopSearchOverlayController(
        context: context, allProducts: widget.allProducts);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openSearchBar() {
    setState(() => _showSearchBar = true);
    _controller.openSearchBar();
  }

  void _closeSearchBar() {
    setState(() => _showSearchBar = false);
    _controller.closeSearchBar();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_showSearchBar)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ShopSearchBar(
              controller: _controller.controller,
              onClose: _closeSearchBar,
              onChanged: _controller.onChanged,
              showDropdown: true,
              dropdownResults: [], // Overlay handles dropdown
            ),
          ),
      ],
    );
  }

  // Expose a callback for navbar
  VoidCallback get searchCallback => _openSearchBar;
}
