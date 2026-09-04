// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:animation/main.dart';

void main() {
  testWidgets('ArcadeLaunch UI and credits test', (WidgetTester tester) async {
    await tester.pumpWidget(const ArcadeLaunch());
    expect(find.text('ARCADE LAUNCH'), findsOneWidget);
    expect(find.textContaining('3 CREDITS'), findsOneWidget);

    await tester.tap(find.text('INSERT COIN (+2 CREDITS)'));
    await tester.pump();

    expect(find.textContaining('5 CREDITS'), findsOneWidget);
  });
}
