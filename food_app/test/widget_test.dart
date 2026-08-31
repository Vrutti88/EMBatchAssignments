import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/foodapp.dart';

void main() {
  group('FlavorCraft Food Dashboard Tests', () {
    testWidgets('Desktop / Tablet view loads all sections & filters', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Task 1: App Brand Name
      expect(find.text('FlavorCraft'), findsWidgets);
      expect(find.text('Popular Dishes'), findsOneWidget);

      // Task 3: Offers menu item
      expect(find.text('Offers'), findsOneWidget);

      // Task 11 & Task 15: Search and Long Food Name
      await tester.enterText(find.byType(TextField), 'Extra Cheese');
      await tester.pumpAndSettle();
      expect(
        find.text('Extra Cheese Paneer Tandoori Pizza'),
        findsOneWidget,
      );

      // Task 12: No food message when search has no results
      await tester.enterText(find.byType(TextField), 'NonExistentFoodItemXYZ');
      await tester.pumpAndSettle();
      expect(find.text('No food available'), findsOneWidget);

      // Reset filter
      await tester.tap(find.text('View All Menu'));
      await tester.pumpAndSettle();
      expect(find.text('Margherita Pizza'), findsOneWidget);
    });

    testWidgets('Mobile view loads responsive layout & Drawer', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844); // iPhone dimensions
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Mobile AppBar check
      expect(find.text('FlavorCraft'), findsWidgets);
      expect(find.text('Popular Dishes'), findsOneWidget);
    });

    testWidgets('Order Details navigation and Go Back button work', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Scroll down to reveal recent orders
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -700),
      );
      await tester.pumpAndSettle();

      // Tap on order #1001
      final orderItem = find.textContaining('#1001');
      expect(orderItem, findsWidgets);
      await tester.tap(orderItem.first);
      await tester.pumpAndSettle();

      // Task 16: Verify Order Details screen
      expect(find.text('Order Details (#1001)'), findsOneWidget);
      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('Margherita Pizza + Coke'), findsOneWidget);

      // Task 17: Tap 'Go Back' button
      await tester.tap(find.text('Go Back'));
      await tester.pumpAndSettle();

      // Should be back on dashboard
      expect(find.text('Popular Dishes'), findsOneWidget);
    });

    testWidgets('Offers screen opens and applies discount code', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Tap Offers menu item
      await tester.tap(find.text('Offers'));
      await tester.pumpAndSettle();

      expect(find.text('Exclusive Offers & Deals'), findsOneWidget);
      expect(find.text('FLAVOR50'), findsOneWidget);

      // Tap Apply Code
      await tester.tap(find.text('Apply Code').first);
      await tester.pumpAndSettle();

      // Go back
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Popular Dishes'), findsOneWidget);
    });

    testWidgets('Add to Cart, Live Badge & Checkout modal works', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Click Add on first food item
      final addButton = find.text('Add').first;
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify cart count badge
      expect(find.text('Cart (1)'), findsOneWidget);

      // Open Cart Modal Sheet
      await tester.tap(find.text('Cart (1)'));
      await tester.pumpAndSettle();

      expect(find.text('Order Cart'), findsOneWidget);
      expect(find.text('Confirm & Place Order'), findsOneWidget);

      // Place Order
      await tester.tap(find.text('Confirm & Place Order'));
      await tester.pumpAndSettle();

      // Cart reset
      expect(find.text('Cart'), findsOneWidget);
    });
  });
}
