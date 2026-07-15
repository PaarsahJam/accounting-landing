import 'package:flutter/material.dart';

class SnackbarService {
  SnackbarService._();

  static final SnackbarService instance = SnackbarService._();

  void showSuccess(BuildContext context, String message) {
    _show(context, message, success: true);
  }

  void showError(BuildContext context, String message) {
    _show(context, message, success: false);
  }

  void _show(BuildContext context, String message, {required bool success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green.shade700 : Colors.red.shade700,
      ),
    );
  }
}
