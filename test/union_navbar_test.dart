import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/union_navbar.dart';
import 'package:union_shop/widgets/cart_icon_button.dart';

void main() {
  group('UnionNavBar Widget Tests', () {
    testWidgets('renders all main UI elements (desktop)',
        (WidgetTester tester) async {
      bool searchTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 900)),
            child: Scaffold(
              body: UnionNavBar(onSearchIconTap: () => searchTapped = true),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Banner
      expect(find.textContaining('Student Saver Weekend'), findsOneWidget);
      // Logo
      expect(find.byType(Image), findsOneWidget);
      // Nav links
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Shop'), findsOneWidget);
      expect(find.text('Print Shack'), findsOneWidget);
      expect(find.text('About Us'), findsOneWidget);
      // Search icon
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Cart icon
      expect(find.byType(CartIconButton), findsOneWidget);
      // Person icon
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('renders mobile menu and triggers search callback',
        (WidgetTester tester) async {
      bool searchTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 900)),
            child: Scaffold(
              body: UnionNavBar(onSearchIconTap: () => searchTapped = true),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Banner
      expect(find.textContaining('Student Saver Weekend'), findsOneWidget);
      // Logo
      expect(find.byType(Image), findsOneWidget);
      // Menu label
      expect(find.text('Menu'), findsOneWidget);
      // Search icon
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Tap search icon
      await tester.tap(find.byIcon(Icons.search));
      expect(searchTapped, isTrue);
    });

    testWidgets('mobile menu navigates to correct routes',
        (WidgetTester tester) async {
      final mobileRoutes = <String, WidgetBuilder>{
        '/': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Home Page'),
                ],
              ),
            ),
        '/collections': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Shop Page'),
                ],
              ),
            ),
        '/print-shack': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Print Shack Page'),
                ],
              ),
            ),
        '/about': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('About Us Page'),
                ],
              ),
            ),
      };
      Future<void> pumpMobileNav(String route) async {
        await tester.pumpWidget(MaterialApp(
          routes: mobileRoutes,
          initialRoute: route,
          builder: (context, child) => MediaQuery(
            data: MediaQueryData(size: Size(400, 900)),
            child: child!,
          ),
        ));
        await tester.pumpAndSettle();
      }

      // Home
      await pumpMobileNav('/');
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home').last);
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget);
      // Shop
      await pumpMobileNav('/');
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Shop').last);
      await tester.pumpAndSettle();
      expect(find.text('Shop Page'), findsOneWidget);
      // Print Shack
      await pumpMobileNav('/');
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Print Shack').last);
      await tester.pumpAndSettle();
      expect(find.text('Print Shack Page'), findsOneWidget);
      // About Us
      await pumpMobileNav('/');
      await tester.tap(find.text('Menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('About Us').last);
      await tester.pumpAndSettle();
      expect(find.text('About Us Page'), findsOneWidget);
    });

    testWidgets('desktop nav links and dropdown navigate correctly',
        (WidgetTester tester) async {
      final desktopRoutes = <String, WidgetBuilder>{
        '/': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Home Page'),
                ],
              ),
            ),
        '/essentials': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Essentials Page'),
                ],
              ),
            ),
        '/sale': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Sale Page'),
                ],
              ),
            ),
        '/collections': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Merchandise Page'),
                ],
              ),
            ),
        '/print-shack': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('Print Shack Page'),
                ],
              ),
            ),
        '/about': (context) => Scaffold(
              body: Column(
                children: [
                  const UnionNavBar(),
                  const SizedBox(height: 24),
                  const Text('About Us Page'),
                ],
              ),
            ),
      };
      Future<void> pumpDesktopNav(String route) async {
        await tester.pumpWidget(MaterialApp(
          routes: desktopRoutes,
          initialRoute: route,
          builder: (context, child) => MediaQuery(
            data: MediaQueryData(size: Size(1200, 900)),
            child: child!,
          ),
        ));
        await tester.pumpAndSettle();
      }

      // Home
      await pumpDesktopNav('/');
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Home Page'), findsOneWidget);
      // Essentials (Shop dropdown)
      await pumpDesktopNav('/');
      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Essentials').last);
      await tester.pumpAndSettle();
      expect(find.text('Essentials Page'), findsOneWidget);
      // Sale (Shop dropdown)
      await pumpDesktopNav('/');
      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sale').last);
      await tester.pumpAndSettle();
      expect(find.text('Sale Page'), findsOneWidget);
      // Merchandise (Shop dropdown)
      await pumpDesktopNav('/');
      await tester.tap(find.text('Shop'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merchandise').last);
      await tester.pumpAndSettle();
      expect(find.text('Merchandise Page'), findsOneWidget);
      // Print Shack
      await pumpDesktopNav('/');
      await tester.tap(find.text('Print Shack'));
      await tester.pumpAndSettle();
      expect(find.text('Print Shack Page'), findsOneWidget);
      // About Us
      await pumpDesktopNav('/');
      await tester.tap(find.text('About Us'));
      await tester.pumpAndSettle();
      expect(find.text('About Us Page'), findsOneWidget);
    });
  });
}
