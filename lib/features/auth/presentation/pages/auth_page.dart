import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_placeholder_page.dart';
import '../../../../l10n/l10n.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPlaceholderPage(
        title: context.l10n.authTitle,
      ),
    );
  }
}
