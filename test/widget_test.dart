import 'package:celest/app.dart';
import 'package:celest/core/common/providers/app_service_providers.dart';
import 'package:celest/core/utils/notifications/notification_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late NotificationService notificationService;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    sharedPreferences = await SharedPreferences.getInstance();
    notificationService = NotificationService();
  });

  testWidgets('App boots to dashboard route', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: buildAppServiceOverrides(
          sharedPreferences: sharedPreferences,
          notificationService: notificationService,
        ),
        child: const CelestApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('欢迎回来, Alex'), findsOneWidget);
  });
}
