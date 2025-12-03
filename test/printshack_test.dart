import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/printshack_page.dart';
import 'package:union_shop/cart_state.dart';
import'package:union_shop/widgets/union_navbar.dart';

void main() {
  group('PersonalisationPage Widget Tests', () {
    testWidgets('renders all main UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PersonalisationPage(),
        ),
      );
      // Navbar
      expect(find.byType(UnionNavBar), findsOneWidget);
      // Product image
      expect(find.byType(Image), findsOneWidget);
      // Product title
      expect(find.text('Personalisation'), findsOneWidget);
      // Product price
      expect(find.text('£3.00'), findsOneWidget);
      // Size selector
      expect(find.text('Lines:'), findsOneWidget);
      expect(find.byType(DropdownButton<String>), findsOneWidget);
      // Custom message input
      expect(find.byType(TextField), findsOneWidget);
      // Description
      expect(find.text('Description'), findsOneWidget);
      // Add to cart button
      expect(find.text('Add to cart'), findsOneWidget);
      // Footer
      expect(find.text('Placeholder Footer'), findsOneWidget);
    });

    testWidgets('can select size and enter message',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PersonalisationPage(),
        ),
      );
      // Select size
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Two Lines of Text').last);
      await tester.pumpAndSettle();
      expect(find.text('Two Lines of Text'), findsOneWidget);
      // Enter message
      await tester.enterText(find.byType(TextField), 'Hello\nWorld');
      expect(find.text('Hello\nWorld'), findsOneWidget);
    });

    testWidgets('shows confirmation and adds to cart',
        (WidgetTester tester) async {
      final cartState = CartState();
      await tester.pumpWidget(
        MaterialApp(
          home: PersonalisationPage(),
        ),
      );
      // Tap add to cart
      await tester.tap(find.text('Add to cart'));
      await tester.pump();
      // Confirmation message appears
      expect(find.textContaining('has been added to cart!'), findsOneWidget);
    });
  });
}
