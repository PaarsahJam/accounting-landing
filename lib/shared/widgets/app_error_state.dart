import 'package:flutter/material.dart';

/// A polished error state widget with icon, message and optional retry.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
  });

  final String message;

  /// If provided, a retry button is shown below the message.
  final VoidCallback? onRetry;

  /// Label for the retry button. Falls back to 'Retry'.
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Semantics(
          label: 'Error: $message',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: cs.error,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: cs.onSurface,
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                FilledButton.tonal(
                  onPressed: onRetry,
                  child: Text(retryLabel ?? 'Retry'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
