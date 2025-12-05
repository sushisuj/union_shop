import 'package:flutter/material.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class EssentialsPage2 extends StatelessWidget {
  const EssentialsPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const UnionNavBar(),
          const SizedBox(height: 32),
          const Center(
            child: Text(
              'Essentials - Page 2',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Previous Page'),
                ),
              ],
            ),
          ),
          // Large space for future product content
          const Expanded(
            child: SizedBox(),
          ),
          FooterWidget(onSearchTap: () {}),
        ],
      ),
    );
  }
}
