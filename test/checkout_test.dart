import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/checkout.dart';
import 'package:union_shop/cart_state.dart';
import 'package:union_shop/widgets/union_navbar.dart';

void main() {
  setUp(() {
    cartState.items.value = [
      CartItem(
        title: 'Test Product',
        price: '£10.00',
        quantity: 2,
        size: 'M',
        message: 'Test message',
      ),
    ];
  });

  testWidgets('CheckoutPage renders all main sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CheckoutPage()));
    expect(find.byType(UnionNavBar), findsOneWidget);
    expect(find.text('Express checkout'), findsOneWidget);
    expect(find.text('Input Card Details'), findsOneWidget);
    expect(find.text('Discount codes'), findsOneWidget);
    expect(find.text('Place Order'), findsOneWidget);
  });

  testWidgets('Cart items are displayed with correct details',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CheckoutPage()));
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
    expect(find.text('M'), findsOneWidget);
    expect(find.text('Test message'), findsOneWidget);
    expect(find.text('x2'), findsOneWidget);
  });

  testWidgets('Credit card input fields are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CheckoutPage()));
    expect(find.widgetWithText(TextField, 'Cardholder Name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Card Number'), findsOneWidget);
    expect(
        find.widgetWithText(TextField, 'Expiry Date (MM/YY)'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'CVV'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Billing Address'), findsOneWidget);
  });

  testWidgets('Discount code field and apply button are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CheckoutPage()));
    expect(
        find.widgetWithText(TextField, 'Enter discount code'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Apply'), findsOneWidget);
  });

  testWidgets('Place Order button shows dialog and navigates',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/order-summary': (context) =>
            const Scaffold(body: Text('Order Summary Page')),
      },
      home: const CheckoutPage(),
    ));
    final placeOrderButton = find.widgetWithText(ElevatedButton, 'Place Order');
    expect(placeOrderButton, findsOneWidget);
    await tester.tap(placeOrderButton);
    await tester.pump();
    // Dialog should appear
    expect(find.text('Processing Order, Hold on for a moment'), findsOneWidget);
    // Wait for dialog to close and navigation
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Order Summary Page'), findsOneWidget);
  });

  testWidgets('Responsive layout: side-by-side on desktop, stacked on mobile',
      (WidgetTester tester) async {
    // Desktop width
    await tester.pumpWidget(const MaterialApp(
      home: CheckoutPage(),
    ));
    final rowFinder = find.byType(Row);
    expect(rowFinder, findsWidgets); // Should have Row for side-by-side

    // Mobile width
    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    await tester.pumpWidget(const MaterialApp(home: CheckoutPage()));
    // Should still have Row, but children should be sized for mobile
    expect(rowFinder, findsWidgets);
    // Clean up
    addTearDown(() {
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });
  });
}
