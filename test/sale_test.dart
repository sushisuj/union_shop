import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/sale_page.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  group('SalePage Widget Tests', () {
    testWidgets('renders all main UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: SalePage(),
          ),
        ),
      );
      // Header
      expect(find.textContaining('Sale Picks'), findsOneWidget);
      // Navbar
      expect(find.byType(UnionNavBar), findsOneWidget);
      // Search bar
      expect(find.byType(TextField), findsOneWidget);
      // Category dropdown
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      // Product cards
      expect(find.byType(Card), findsWidgets);
      // Footer
      expect(find.byType(FooterWidget), findsOneWidget);
    });

    testWidgets('can search and filter products', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: SalePage(),
          ),
        ),
      );
      // Search for sunglasses
      await tester.enterText(find.byType(TextField), 'sunglasses');
      await tester.pumpAndSettle();
      expect(find.text('Sunglasses'), findsOneWidget);
      // Filter by category
      await tester.ensureVisible(find.byType(DropdownButton<String>));
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jumpers').last);
      await tester.pumpAndSettle();
      expect(find.text('Fleece Jacket Mens'), findsOneWidget);
      expect(find.text('Fleece Jacket Womens'), findsOneWidget);
    });

    testWidgets('shows sale price and strikethrough',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 1600)),
            child: SalePage(),
          ),
        ),
      );
      // Find a product with sale price
      expect(find.text('£19.99'), findsOneWidget); // Sunglasses original price
      expect(find.text('£10.99'), findsOneWidget); // Sunglasses sale price
      // Strikethrough style
      final priceText = tester.widget<Text>(find.text('£19.99'));
      expect(priceText.style?.decoration, TextDecoration.lineThrough);
      final saleText = tester.widget<Text>(find.text('£10.99'));
      expect(saleText.style?.color, Colors.red);
    });
  });
}
