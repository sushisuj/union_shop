import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  testWidgets('App launches and shows hero section and footer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();
    expect(find.text('Welcome to the Union Shop'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
  });

  testWidgets('Footer search link triggers search bar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsWidgets);
  });

  testWidgets('Shop dropdown opens (text only)', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Shop'));
    await tester.pumpAndSettle();
    // Check for dropdown options (adjust text as needed)
    expect(find.text('Essentials'), findsWidgets);
    expect(find.text('Sale'), findsWidgets);
  });

  testWidgets('Search bar filters products by text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Hoodie');
    await tester.pumpAndSettle();
    expect(find.textContaining('Hoodie'), findsWidgets);
  });

  testWidgets('Footer navigation links are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const UnionShopApp());
    await tester.pumpAndSettle();
    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.text('FAQ'), findsOneWidget);
  });
}
