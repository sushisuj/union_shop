// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClose;
  final ValueChanged<String> onChanged;
  final bool showDropdown;
  final List<Widget> dropdownResults;

  const ShopSearchBar({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onChanged,
    required this.showDropdown,
    required this.dropdownResults,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search the entire shop...',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    ),
                    onChanged: onChanged,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onClose,
                ),
              ],
            ),
          ),
        ),
        if (showDropdown && dropdownResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              children: dropdownResults,
            ),
          ),
      ],
    );
  }
}
