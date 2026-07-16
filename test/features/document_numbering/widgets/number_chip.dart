// lib/features/document_numbering/widgets/number_chip.dart
import 'package:flutter/material.dart';

class NumberChip extends StatelessWidget {
  final String number;

  const NumberChip({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(number, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
    );
  }
}
