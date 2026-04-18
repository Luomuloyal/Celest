import 'package:flutter/widgets.dart';

import 'app.dart';
import 'injection_container.dart' as di;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  runApp(const CelestApp());
}
