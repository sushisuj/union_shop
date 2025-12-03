import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('ProductPage Widget Tests', () {
    testWidgets('renders all main UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: ProductPage(),
          ),
        ),
      );
      // Navbar
      expect(find.byType(UnionNavBar), findsOneWidget);
      // Product image (allow multiple images)
      expect(find.byType(Image), findsWidgets);
      // Product title
      expect(find.text('Placeholder Product'), findsOneWidget);
      // Product price
      expect(find.text('\$0.00'), findsOneWidget);
      // Size selector
      expect(find.text('Size:'), findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      // Description
      expect(find.text('Description'), findsOneWidget);
      // Add to cart button
      expect(find.text('Add to cart'), findsOneWidget);
      // Footer
      expect(find.byType(FooterWidget), findsOneWidget);
    });

    testWidgets('can select size and add to cart', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: ProductPage(
              initialProduct: ProductDetails(
                title: 'Test Product',
                price: '£9.99',
                imageUrl: 'https://via.placeholder.com/300',
                description: 'Test description',
                sizes: ['XS', 'S', 'M', 'L', 'XL'],
              ),
            ),
          ),
        ),
      );
      // Select size
      await tester.ensureVisible(find.byType(DropdownButton<String>));
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('XL').last);
      await tester.pumpAndSettle();
      expect(find.text('XL'), findsOneWidget);
      // Tap add to cart
      await tester.ensureVisible(find.text('Add to cart'));
      await tester.tap(find.text('Add to cart'));
      await tester.pumpAndSettle();
      // Confirmation message appears
      expect(find.textContaining('has been added to cart!'), findsOneWidget);
    });

    testWidgets('shows correct product details', (WidgetTester tester) async {
      final product = ProductDetails(
        title: 'Special Product',
        price: '£19.99',
        imageUrl: 'https://via.placeholder.com/300',
        description: 'Special description',
        sizes: ['One Size'],
      );
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: ProductPage(initialProduct: product),
          ),
        ),
      );
      expect(find.text('Special Product'), findsOneWidget);
      expect(find.text('£19.99'), findsOneWidget);
      expect(find.text('Special description'), findsOneWidget);
      expect(find.text('One Size'), findsOneWidget);
    });
  });
}
