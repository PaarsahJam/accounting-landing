// lib/features/fiscal_periods/presentation/closing_confirmation_dialog.dart

import 'package:flutter/material.dart';

class ClosingConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Year-End Closing'),
      content: Text('Are you sure you want to close the year-end?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform closing logic here.
            Navigator.of(context).pop();
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
