import 'package:flutter/foundation.dart';

abstract final class PlatformInfo {
  static bool get isWeb => kIsWeb;
}
