import 'package:flutter/widgets.dart';

import '../../constants/app_breakpoints.dart';
import '../../theme/app_spacing.dart';

abstract final class AppPagePadding {
  static EdgeInsets content(
    BuildContext context, {
    double? top,
    double? bottom,
  }) {
    final horizontal = horizontalValue(context);

    return EdgeInsets.fromLTRB(
      horizontal,
      top ?? AppSpacing.pageVertical,
      horizontal,
      bottom ?? AppSpacing.pageVertical,
    );
  }

  static double horizontalValue(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= AppBreakpoints.tablet) {
      return AppSpacing.pageHorizontalWide;
    }

    return AppSpacing.pageHorizontal;
  }

  static double sectionGap(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= AppBreakpoints.desktop) {
      return AppSpacing.xl;
    }

    if (width >= AppBreakpoints.tablet) {
      return AppSpacing.lgMinus;
    }

    return AppSpacing.lg;
  }
}
