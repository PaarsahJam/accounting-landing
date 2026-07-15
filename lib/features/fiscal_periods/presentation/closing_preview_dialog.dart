// lib/features/fiscal_periods/presentation/closing_preview_dialog.dart

import 'package:accounting_app/features/fiscal_periods/domain/closing_entry.dart';
import 'package:flutter/material.dart';

class ClosingPreviewDialog extends StatelessWidget {
  final List<ClosingEntry> entries;

  ClosingPreviewDialog({required this.entries});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Closing Preview'),
      content: SingleChildScrollView(
        child: Column(
          children: entries.map((entry) {
            return ListTile(
              leading: Text(entry.accountCode),
              title: Text('\$${entry.amount.toStringAsFixed(2)}'),
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Confirm'),
        ),
      ],
    );
  }
}