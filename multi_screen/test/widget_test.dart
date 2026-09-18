import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_screen/main.dart';

void main() {
  testWidgets('MultiScreen navigation and validation flow test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    // 1. Build MultiScreenApp
    await tester.pumpWidget(const MultiScreenApp());
    await tester.pumpAndSettle();

    // Verify Home Screen widgets
    expect(find.text('MultiScreen App'), findsOneWidget);
    expect(find.text('Welcome to the\nRegistration Portal'), findsOneWidget);
    final proceedBtn = find.text('Proceed to Registration');
    expect(proceedBtn, findsOneWidget);

    // 2. Navigate to Form Screen
    await tester.ensureVisible(proceedBtn);
    await tester.tap(proceedBtn);
    await tester.pumpAndSettle();

    // Verify Registration Form loaded
    expect(find.text('Registration Form'), findsOneWidget);
    final submitBtn = find.text('Submit & View Details');
    expect(submitBtn, findsOneWidget);

    // 3. Tap submit with empty fields -> verify validation errors
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);

    // 4. Fill in valid data
    final nameField = find.widgetWithText(TextFormField, 'e.g. John Doe');
    await tester.ensureVisible(nameField);
    await tester.enterText(nameField, 'John Doe');

    final emailField = find.widgetWithText(TextFormField, 'e.g. name@example.com');
    await tester.ensureVisible(emailField);
    await tester.enterText(emailField, 'john.doe@example.com');

    final phoneField = find.widgetWithText(TextFormField, 'e.g. 9876543210');
    await tester.ensureVisible(phoneField);
    await tester.enterText(phoneField, '9876543210');

    final passField = find.widgetWithText(TextFormField, 'At least 6 characters');
    await tester.ensureVisible(passField);
    await tester.enterText(passField, 'password123');

    final confirmPassField = find.widgetWithText(TextFormField, 'Re-enter your password');
    await tester.ensureVisible(confirmPassField);
    await tester.enterText(confirmPassField, 'password123');

    // Check Terms Checkbox
    final checkbox = find.byType(Checkbox);
    await tester.ensureVisible(checkbox);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    // 5. Submit Form
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    // 6. Verify Detail Screen is reached with submitted user data
    expect(find.text('User Profile Details'), findsOneWidget);
    expect(find.text('John Doe'), findsWidgets);
    expect(find.text('john.doe@example.com'), findsWidgets);
    expect(find.text('9876543210'), findsOneWidget);
    expect(find.text('JD'), findsOneWidget); // User initials badge

    // 7. Test Return to Home from Detail Screen
    final returnHomeBtn = find.text('Return to Home');
    await tester.ensureVisible(returnHomeBtn);
    await tester.tap(returnHomeBtn);
    await tester.pumpAndSettle();

    // Should be back at Home Screen
    expect(find.text('MultiScreen App'), findsOneWidget);
  });

  testWidgets('Quick preview demo profile navigates to Detail and back', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MultiScreenApp());
    await tester.pumpAndSettle();

    final previewBtn = find.text('Quick Preview Demo Profile');
    await tester.ensureVisible(previewBtn);
    await tester.tap(previewBtn);
    await tester.pumpAndSettle();

    expect(find.text('User Profile Details'), findsOneWidget);
    expect(find.text('Vrutti Patil'), findsWidgets);
    expect(find.text('vrutti.patil@example.com'), findsWidgets);

    // Tap back button
    final backBtn = find.byIcon(Icons.arrow_back_ios_new_rounded);
    await tester.tap(backBtn);
    await tester.pumpAndSettle();

    expect(find.text('MultiScreen App'), findsOneWidget);
  });
}
