import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_ui/main.dart';

void main() {
  testWidgets('Dashboard renders properly in mobile viewport', (WidgetTester tester) async {
    // Set mobile size: 400 x 850
    tester.view.physicalSize = const Size(400, 850);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const DashboardApp());
    await tester.pumpAndSettle();

    // Verify key titles and sections
    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(find.text('Total Revenue'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);
    expect(find.text('Weekly Performance'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);
    expect(find.text('Available Balance'), findsOneWidget);

    // Verify mobile navigation bar is present
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });

  testWidgets('Dashboard renders properly in tablet viewport', (WidgetTester tester) async {
    // Set tablet size: 768 x 1024
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const DashboardApp());
    await tester.pumpAndSettle();

    // Verify key sections are present
    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(find.text('Total Revenue'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('Dashboard renders properly in desktop viewport', (WidgetTester tester) async {
    // Set desktop size: 1200 x 900
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const DashboardApp());
    await tester.pumpAndSettle();

    // Verify key sections are present
    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(find.text('Total Revenue'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);

    // Verify desktop navigation rail is present
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
