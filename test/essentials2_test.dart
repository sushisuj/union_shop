import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:union_shop/essentials2.dart';
import 'package:union_shop/product_page.dart';

void main() {
  testWidgets('EssentialsPage2 displays Sandwich product',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: EssentialsPage2()),
    );
    expect(find.text('Sandwich'), findsOneWidget);
    expect(find.text('£1.99'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('Dropdown filter hides Sandwich if category does not match',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: EssentialsPage2()),
    );
    // Open dropdown and select 'Jumpers'
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jumpers').last);
    await tester.pumpAndSettle();
    expect(find.text('Sandwich'), findsNothing);
  });

  testWidgets('Search hides Sandwich if query does not match',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: EssentialsPage2()),
    );
    await tester.enterText(find.byType(TextField).first, 'john');
    await tester.pumpAndSettle();
    expect(find.text('Sandwich'), findsNothing);
  });

  testWidgets('Search shows Sandwich if query matches',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: EssentialsPage2()),
    );
    await tester.enterText(find.byType(TextField).first, 'san');
    await tester.pumpAndSettle();
    expect(find.text('Sandwich'), findsOneWidget);
  });

  testWidgets('Tapping product navigates to ProductPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: EssentialsPage2()),
    );
    await tester.tap(find.text('Sandwich'));
    await tester.pumpAndSettle();
    expect(find.byType(ProductPage), findsOneWidget);
  });
}
