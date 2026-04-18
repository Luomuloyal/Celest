import 'package:flutter/material.dart';

import '../constants/app_breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= AppBreakpoints.desktop && desktop != null) {
      return desktop!;
    }

    if (width >= AppBreakpoints.tablet && tablet != null) {
      return tablet!;
    }

    return mobile;
  }
}
