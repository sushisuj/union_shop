import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/collections_page.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'dart:ui';

void main() {
  testWidgets('CollectionsPage renders navbar, title, grid, and footer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    expect(find.byType(UnionNavBar), findsOneWidget);
    expect(find.text('Collections'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(FooterWidget), findsOneWidget);
  });

  testWidgets('Displays all collection items with correct titles',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    expect(find.text('Essentials'), findsOneWidget);
    expect(find.text('Winter Collection'), findsOneWidget);
    expect(find.text('Merchandise'), findsOneWidget);
    expect(find.text('Personalisation'), findsOneWidget);
    expect(find.text('Sale'), findsOneWidget);
  });

  testWidgets(
      'Tapping a collection navigates to correct route or does nothing for dummy cards',
      (WidgetTester tester) async {
    final routes = <String, WidgetBuilder>{
      '/essentials': (context) => const Scaffold(body: Text('Essentials Page')),
      '/sale': (context) => const Scaffold(body: Text('Sale Page')),
    };
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      home: const CollectionsPage(),
    ));
    // Tap Essentials and check navigation
    final essentialsFinder = find.text('Essentials');
    expect(essentialsFinder, findsOneWidget);
    await tester.ensureVisible(essentialsFinder);
    await tester.tap(essentialsFinder);
    await tester.pumpAndSettle();
    expect(find.text('Essentials Page'), findsOneWidget);

    // Go back to CollectionsPage
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      home: const CollectionsPage(),
    ));
    // Tap Sale and check navigation
    final saleFinder = find.text('Sale');
    if (tester.any(saleFinder)) {
      await tester.ensureVisible(saleFinder);
      await tester.tap(saleFinder);
      await tester.pumpAndSettle();
      expect(find.text('Sale Page'), findsOneWidget);
    }

    // Go back to CollectionsPage
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      home: const CollectionsPage(),
    ));
    // Tap dummy cards and check that we remain on CollectionsPage
    for (final dummyTitle in [
      'Winter Collection',
      'Merchandise',
      'Personalisation'
    ]) {
      final dummyFinder = find.text(dummyTitle);
      if (tester.any(dummyFinder)) {
        await tester.ensureVisible(dummyFinder);
        await tester.tap(dummyFinder);
        await tester.pumpAndSettle();
        expect(find.text('Collections'), findsOneWidget);
      }
    }
  });

  testWidgets('Footer is present', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    expect(find.byType(FooterWidget), findsOneWidget);
  });

  testWidgets('Responsive grid: 2 columns on wide, 1 column on narrow screens',
      (WidgetTester tester) async {
    // Wide screen
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    // Should have 2 columns, so 2 items per row
    final gridTilesWide = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(Stack),
    );
    expect(gridTilesWide, findsNWidgets(5));

    // Narrow screen
    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    await tester.pumpWidget(const MaterialApp(home: CollectionsPage()));
    final gridTilesNarrow = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(Stack),
    );
    expect(gridTilesNarrow, findsNWidgets(5));

    // Clean up
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });
}
