import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/about_page.dart';
import 'package:union_shop/widgets/union_navbar.dart';

void main() {
  testWidgets('AboutPage displays all main text sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutPage(),
      ),
    );

    expect(find.text('About us'), findsOneWidget);
    expect(find.text('Welcome to the Union Shop!'), findsOneWidget);
    expect(
        find.textContaining(
            'We’re dedicated to giving you the very best University branded products'),
        findsOneWidget);
    expect(
        find.text(
            'All online purchases are available for delivery or instore collection!'),
        findsOneWidget);
    expect(
        find.textContaining('We hope you enjoy our products'), findsOneWidget);
    expect(find.text('Happy shopping!'), findsOneWidget);
    expect(find.text('The Union Shop & Reception Team'), findsOneWidget);
  });

  testWidgets('AboutPage has a personalisation service link',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AboutPage(),
      ),
    );

    final personalisationFinder = find.text('personalisation service!');
    expect(personalisationFinder, findsOneWidget);

    // Tap the link and verify navigation intent (route name)
    await tester.tap(personalisationFinder);
    await tester.pumpAndSettle();
    // You may want to mock or check Navigator.pushNamed was called with '/print-shack'
  });

  testWidgets('Navbar search icon is present and clickable',
      (WidgetTester tester) async {
    bool searchTapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UnionNavBar(onSearchIconTap: () {
            searchTapped = true;
          }),
        ),
      ),
    );

    final searchIconFinder = find.byIcon(Icons.search);
    expect(searchIconFinder, findsOneWidget);

    await tester.tap(searchIconFinder);
    expect(searchTapped, isTrue);
  });

  testWidgets('Navbar person and cart icons are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UnionNavBar(onSearchIconTap: () {}),
        ),
      ),
    );

    expect(find.byIcon(Icons.person_outline), findsOneWidget);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  });
}
