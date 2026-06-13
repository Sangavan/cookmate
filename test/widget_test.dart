import 'package:flutter_test/flutter_test.dart';

import 'package:cookmate/main.dart';

void main() {
  testWidgets('App launches and shows CookMate title',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CookMateApp());

    // Verify the placeholder screen is shown.
    expect(find.textContaining('CookMate'), findsOneWidget);
  });
}