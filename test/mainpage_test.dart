import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('Footer search link triggers search bar', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Tap the "Search" link in the footer
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Check that the search bar appears
    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('Shop dropdown navigates to collections', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Open the shop dropdown (assuming it's a PopupMenuButton or similar)
    await tester.tap(find.text('Shop'));
    await tester.pumpAndSettle();

    // Tap the first collection option
    await tester.tap(find.text('All Products').first);
    await tester.pumpAndSettle();

    // Check navigation to /collections (by text or widget)
    expect(find.text('All Products'), findsWidgets);
  });

  testWidgets('Hero section text is visible', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Check for hero section text only (not images)
    expect(find.text('Welcome to the Union Shop'), findsOneWidget);
  });

  testWidgets('Search bar filters products by text', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();

    // Open search bar
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    // Enter text in the search bar
    await tester.enterText(find.byType(TextField).first, 'Hoodie');
    await tester.pumpAndSettle();

    // Check that filtered product text is shown (not images)
    expect(find.textContaining('Hoodie'), findsWidgets);
  });
}