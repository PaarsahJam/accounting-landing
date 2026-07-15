import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signup)),
      body: Center(
        child: Semantics(
          label: l10n.signupTodoMessage,
          child: Text(l10n.signupTodoMessage),
        ),
      ),
    );
  }
}
