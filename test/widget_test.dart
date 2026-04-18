import 'package:flutter_test/flutter_test.dart';

import 'package:celest/app.dart';

void main() {
  testWidgets('App boots to dashboard route', (WidgetTester tester) async {
    await tester.pumpWidget(const CelestApp());
    await tester.pumpAndSettle();

    expect(find.text('Dashboard feature placeholder'), findsOneWidget);
  });
}
