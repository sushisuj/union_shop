import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/order_summary_page.dart';
import 'package:union_shop/cart_state.dart';

void main() {
  setUp(() {
    // Set up a fake cart for each test
    cartState.items.value = [
      const CartItem(
          title: 'Test Product', size: 'M', price: '£10.00', quantity: 2),
      const CartItem(
          title: 'Another Product', size: 'L', price: '£5.00', quantity: 1),
    ];
  });

  tearDown(() {
    cartState.items.value = [];
  });

  testWidgets('renders order summary, success message, and card info',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: OrderSummaryPage(cardEnding: '1234'),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Order Summary'), findsOneWidget);
    expect(find.text('Order successfully placed'), findsOneWidget);
    expect(find.textContaining('Paid with card 1234'), findsOneWidget);
    expect(find.text('Not done Shopping?'), findsOneWidget);
    expect(find.text('Continue Shopping'), findsOneWidget);
    // Check product info
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Another Product'), findsOneWidget);
    expect(find.text('M'), findsOneWidget);
    expect(find.text('L'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
    expect(find.text('£5.00'), findsOneWidget);
    // Grand total
    expect(find.text('£25.00'), findsOneWidget);
  });

  testWidgets('clears cart and navigates on continue shopping',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/order-summary',
      routes: {
        '/': (context) => const Scaffold(body: Text('Home')),
        '/order-summary': (context) =>
            const OrderSummaryPage(cardEnding: '5678'),
      },
    ));
    await tester.pumpAndSettle();
    expect(cartState.items.value.isNotEmpty, isTrue);
    // Ensure the button is visible by scrolling if needed
    final continueButton = find.text('Continue Shopping');
    await tester.ensureVisible(continueButton);
    await tester.tap(continueButton);
    await tester.pumpAndSettle();
    expect(cartState.items.value, isEmpty);
    expect(find.text('Home'), findsOneWidget);
  });
}
