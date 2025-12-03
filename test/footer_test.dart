import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/footer.dart';

void main() {
  testWidgets('FooterWidget displays all main sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FooterWidget(),
        ),
      ),
    );

    expect(find.text('Opening Times'), findsOneWidget);
    expect(find.text('Mon-Fri: 9am - 5pm'), findsOneWidget);
    expect(find.text('Sat: 10am - 4pm'), findsOneWidget);
    expect(find.text('Sun: Closed'), findsOneWidget);
    expect(find.text('Latest Offers'), findsOneWidget);
    expect(find.text('Help and Information'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('FAQ'), findsOneWidget);
  });

  testWidgets('FooterWidget search link triggers callback',
      (WidgetTester tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FooterWidget(onSearchTap: () {
            tapped = true;
          }),
        ),
      ),
    );
    await tester.tap(find.text('Search'));
    expect(tapped, isTrue);
  });

  testWidgets('FooterWidget email field and subscribe button are present',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FooterWidget(),
        ),
      ),
    );
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('SUBSCRIBE'), findsOneWidget);
  });

  testWidgets('FooterWidget links are tappable', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FooterWidget(),
        ),
      ),
    );
    await tester.tap(find.text('Terms and Conditions'));
    await tester.tap(find.text('Contact Us'));
    await tester.tap(find.text('FAQ'));
    // No navigation, just ensure tap does not throw
  });
}
