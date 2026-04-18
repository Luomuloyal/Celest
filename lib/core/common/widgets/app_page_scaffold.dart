import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/theme_context_extension.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    required this.body,
    this.topBar,
    this.bottomNavigationBar,
    this.maxContentWidth = AppSizes.maxContentWidth,
  });

  final Widget body;
  final Widget? topBar;
  final Widget? bottomNavigationBar;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    final background = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          context.appTheme.pageGradientStart,
          context.appTheme.pageGradientEnd,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: DecoratedBox(
        decoration: background,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              if (topBar != null)
                _ConstrainedContent(
                  maxContentWidth: maxContentWidth,
                  child: topBar!,
                ),
              Expanded(
                child: _ConstrainedContent(
                  maxContentWidth: maxContentWidth,
                  child: body,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : SafeArea(
              top: false,
              child: _ConstrainedContent(
                maxContentWidth: maxContentWidth,
                child: bottomNavigationBar!,
              ),
            ),
    );
  }
}

class _ConstrainedContent extends StatelessWidget {
  const _ConstrainedContent({
    required this.maxContentWidth,
    required this.child,
  });

  final double maxContentWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: child,
      ),
    );
  }
}
