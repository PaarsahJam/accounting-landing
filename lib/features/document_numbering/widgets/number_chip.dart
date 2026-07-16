// lib/features/document_numbering/widgets/number_chip.dart

import 'package:flutter/material.dart';

/// Chip that displays a formatted document number such as `PO-2026-000001`.
class NumberChip extends StatelessWidget {
  const NumberChip({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Chip(
      backgroundColor: colorScheme.primaryContainer,
      side: BorderSide(color: colorScheme.primary, width: 1),
      label: Text(
        number,
        style: TextStyle(
          color: colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      visualDensity: VisualDensity.compact,
    );
  }
}
