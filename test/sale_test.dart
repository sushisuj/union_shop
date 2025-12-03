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
      await tester.pumpAndSettle();
      // Header
      expect(find.textContaining('Sale Picks'), findsOneWidget);
      // Navbar
      expect(find.byType(UnionNavBar), findsOneWidget);
      // Search bar (allow multiple TextFields, check for search bar specifically)
      expect(find.byType(TextField), findsWidgets);
      expect(
        find.widgetWithText(TextField, 'Search sale items...'),
        findsOneWidget,
      );
      // Category dropdown
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      // Product cards (allow multiple)
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
      await tester.pumpAndSettle();
      // Search for sunglasses (target search bar specifically)
      await tester.enterText(
        find.widgetWithText(TextField, 'Search sale items...'),
        'sunglasses',
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('Sunglasses'), findsOneWidget);
      // Clear search bar before filtering by category
      await tester.enterText(
        find.widgetWithText(TextField, 'Search sale items...'),
        '',
      );
      await tester.pumpAndSettle();
      // Filter by category
      await tester.ensureVisible(find.byType(DropdownButton<String>));
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Jumpers').last);
      await tester.pumpAndSettle();
      expect(find.textContaining('Fleece Jacket Mens'), findsOneWidget);
      expect(find.textContaining('Fleece Jacket Womens'), findsOneWidget);
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
      await tester.pumpAndSettle();
      // Find a product with sale price
      expect(find.textContaining('£19.99'),
          findsWidgets); // Sunglasses original price
      expect(
          find.textContaining('£10.99'), findsWidgets); // Sunglasses sale price
      // Strikethrough style
      final priceText =
          tester.widget<Text>(find.textContaining('£19.99').first);
      expect(priceText.style?.decoration, TextDecoration.lineThrough);
      final saleText = tester.widget<Text>(find.textContaining('£10.99').first);
      expect(saleText.style?.color, Colors.red);
    });
  });
}
