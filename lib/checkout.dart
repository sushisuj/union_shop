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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            UnionNavBar(onSearchIconTap: _openSearchBar),
            // ...checkout page content will go here...
            FooterWidget(onSearchTap: _scrollToTopAndOpenSearch),
          ],
        ),
      ),
    );
  }
}
