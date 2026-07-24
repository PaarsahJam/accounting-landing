import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/connectivity_service.dart';

class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnline = ref.watch(isOnlineProvider);
    if (isOnline) return const SizedBox.shrink();

    return MaterialBanner(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(Icons.wifi_off, color: Theme.of(context).colorScheme.onErrorContainer),
      content: Text(
        'You are offline. Changes will sync when connected.',
        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
      ),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      actions: [
        TextButton(
          onPressed: () => ScaffoldMessenger.maybeOf(context)?.hideCurrentMaterialBanner(),
          child: Text(
            'Dismiss',
            style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
          ),
        ),
      ],
    );
  }
}
