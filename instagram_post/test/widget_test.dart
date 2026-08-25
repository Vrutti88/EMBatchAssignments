import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_post/main.dart';
import 'package:instagram_post/services_page.dart';

void main() {
  testWidgets('ServicesPage renders successfully with service items',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the AppBar title is displayed.
    expect(find.text('Instagram Services'), findsOneWidget);

    // Verify that service cards are rendered.
    expect(find.byType(ServiceCard), findsWidgets);
    expect(find.text('Content Creation & Reels'), findsOneWidget);
    expect(find.text('Growth & Social Analytics'), findsOneWidget);
  });
}
