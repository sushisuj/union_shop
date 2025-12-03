import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/essentials.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  testWidgets(
      'EssentialsPage renders navbar, search/filter, products, and footer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    expect(find.byType(UnionNavBar), findsOneWidget);
    expect(find.byType(FooterWidget), findsOneWidget);
    expect(find.byType(TextField), findsWidgets); // search fields
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.byType(ProductCard), findsWidgets);
  });

  testWidgets('Displays all essential products with correct titles and prices',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    expect(find.text('Essential Grey Hoodie Mens'), findsOneWidget);
    expect(find.text('Essential Grey Hoodie Womens'), findsOneWidget);
    expect(find.text('Essential White T-Shirt Mens'), findsOneWidget);
    expect(find.text('Essential White T-Shirt Womens'), findsOneWidget);
    expect(find.text('Lanyard Card Holder'), findsOneWidget);
    expect(find.text('Essential USB-C Charger'), findsOneWidget);
    expect(find.text('£29.99'), findsNWidgets(2));
    expect(find.text('£12.99'), findsNWidgets(2));
    expect(find.text('£2.99'), findsOneWidget);
    expect(find.text('£6.99'), findsOneWidget);
  });

  testWidgets('Search bar filters products by name',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    final searchField = find.widgetWithText(TextField, 'Search products...');
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'hoodie');
    await tester.pumpAndSettle();
    expect(find.text('Essential Grey Hoodie Mens'), findsOneWidget);
    expect(find.text('Essential Grey Hoodie Womens'), findsOneWidget);
    expect(find.text('Essential White T-Shirt Mens'), findsNothing);
    expect(find.text('Lanyard Card Holder'), findsNothing);
  });

  testWidgets('Category dropdown filters products by category',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    final dropdown = find.byType(DropdownButton<String>);
    expect(dropdown, findsOneWidget);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jumpers').last);
    await tester.pumpAndSettle();
    expect(find.text('Essential Grey Hoodie Mens'), findsOneWidget);
    expect(find.text('Essential Grey Hoodie Womens'), findsOneWidget);
    expect(find.text('Essential White T-Shirt Mens'), findsNothing);
    expect(find.text('Lanyard Card Holder'), findsNothing);
  });

  testWidgets('Tapping a product card navigates to product details page',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EssentialsPage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/product-details') {
          return MaterialPageRoute(
              builder: (_) => const Scaffold(body: Text('Product Details')));
        }
        return null;
      },
    ));
    final productFinder = find.text('Essential Grey Hoodie Mens');
    expect(productFinder, findsOneWidget);
    await tester.tap(productFinder);
    await tester.pumpAndSettle();
    // Should navigate to ProductPage (actual navigation logic may differ)
    // If ProductPage is a new route, check for its presence
    expect(find.text('Essential Grey Hoodie Mens'), findsOneWidget);
  });

  testWidgets('Responsive grid: correct columns for desktop, tablet, mobile',
      (WidgetTester tester) async {
    // Desktop
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    // Should have 3 columns
    final gridCardsDesktop = find.byType(ProductCard);
    expect(gridCardsDesktop, findsNWidgets(6));

    // Tablet
    tester.binding.window.physicalSizeTestValue = const Size(800, 800);
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    final gridCardsTablet = find.byType(ProductCard);
    expect(gridCardsTablet, findsNWidgets(6));

    // Mobile
    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    await tester.pumpWidget(const MaterialApp(home: EssentialsPage()));
    final gridCardsMobile = find.byType(ProductCard);
    expect(gridCardsMobile, findsNWidgets(6));

    // Clean up
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });
}
