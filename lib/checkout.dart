import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UnionNavBar(onSearchIconTap: _openSearchBar),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkout side (left)
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                          height: 700, // Placeholder height for layout
                          // TODO: Add checkout form content here
                        ),
                      ),
                      // Summary side (right)
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                          height: 700, // Placeholder height for layout
                          // TODO: Add summary content here
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FooterWidget(onSearchTap: _scrollToTopAndOpenSearch),
        ],
      ),
    );
  }
}
