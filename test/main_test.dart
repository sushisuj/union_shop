import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/collections_page.dart';

void main() {
  group('UnionShopApp Widget Tests', () {
    testWidgets('App launches and shows HomeScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      // Check for hero section title
      expect(find.text('Welcome to the Union Shop'), findsOneWidget);
      // Check for footer
      expect(find.text('Help and Information'), findsOneWidget);
    });

    testWidgets('Navigates to ProductPage from ProductCard tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      // Tap first product card
      final productCard = find.byType(ProductCard).first;
      await tester.tap(productCard);
      await tester.pumpAndSettle();
      // Should navigate to ProductPage (route: /product)
      expect(find.byType(ProductPage), findsOneWidget);
    });

    testWidgets('Navigates to AboutPage via nav', (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      // Find About Us nav link and tap
      final aboutNav = find.text('About Us');
      await tester.tap(aboutNav);
      await tester.pumpAndSettle();
      expect(find.byType(AboutPage), findsOneWidget);
    });

    testWidgets('Navigates to CollectionsPage via nav',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      // Find Shop nav link and tap
      final shopNav = find.text('Shop');
      await tester.tap(shopNav);
      await tester.pumpAndSettle();
      expect(find.byType(CollectionsPage), findsOneWidget);
    });

    testWidgets('Search bar overlay appears when triggered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const UnionShopApp());
      await tester.pumpAndSettle();
      // Tap Search in footer
      final searchFooter = find.text('Search');
      await tester.tap(searchFooter);
      await tester.pumpAndSettle();
      // Search bar should be visible
      expect(find.byType(TextField), findsWidgets);
    });
  });
}
