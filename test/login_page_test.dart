import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/login_page.dart';

void main() {
  testWidgets('LoginPage shows all main UI elements',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.text('Enter your details to continue'), findsOneWidget);
    expect(
        find.byType(TextField), findsNWidgets(2)); // Email and password fields
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('Need an account?'), findsOneWidget);
  });

  testWidgets('Tapping Continue does nothing (no-op)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.tap(find.text('Continue'));
    await tester.pump();
    // No navigation or snackbar expected
  });

  testWidgets('Tapping Create an account does nothing (no-op)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));
    await tester.tap(find.text('Create an account'));
    await tester.pump();
    // No navigation or snackbar expected
  });
}
