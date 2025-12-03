import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/cart_icon_button.dart';
import 'package:union_shop/cart_state.dart';

void main() {
  testWidgets('CartIconButton displays icon and no badge when cart is empty',
      (WidgetTester tester) async {
    cartState.items.value = [];
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartIconButton(onPressed: () {
            pressed = true;
          }),
        ),
      ),
    );
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
    expect(find.text('0'), findsNothing);
    await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
    expect(pressed, isTrue);
  });

  testWidgets('CartIconButton displays correct badge count',
      (WidgetTester tester) async {
    cartState.items.value = [
      CartItem(title: 'A', size: 'M', price: '1.00', quantity: 2),
      CartItem(title: 'B', size: 'L', price: '2.00', quantity: 3),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartIconButton(onPressed: () {}),
        ),
      ),
    );
    // Badge should show total quantity (2+3=5)
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('CartIconButton badge hides when cart is cleared',
      (WidgetTester tester) async {
    cartState.items.value = [
      CartItem(title: 'A', size: 'M', price: '1.00', quantity: 1)
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CartIconButton(onPressed: () {}),
        ),
      ),
    );
    expect(find.text('1'), findsOneWidget);
    cartState.items.value = [];
    await tester.pump();
    expect(find.text('1'), findsNothing);
  });
}
