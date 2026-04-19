import 'package:celest/app.dart';
import 'package:celest/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await configureDependencies();
  });

  testWidgets('App boots to dashboard route', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: CelestApp()));
    await tester.pumpAndSettle();

    expect(find.text('欢迎回来, Alex'), findsOneWidget);
  });
}
