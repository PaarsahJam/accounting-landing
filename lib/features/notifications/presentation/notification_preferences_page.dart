import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/notification_channel.dart';
import '../domain/notification_preference.dart';
import '../domain/notification_preferences_controller.dart';
import '../domain/notification_type.dart';

class NotificationPreferencesPage extends ConsumerWidget {
  const NotificationPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPrefs = ref.watch(notificationPreferencesControllerProvider);

    return ResponsivePageScaffold(
      title: 'Notification Preferences',
      child: asyncPrefs.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (prefs) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _GlobalToggle(prefs: prefs),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Notification Types'),
            const SizedBox(height: 8),
            for (final type in NotificationType.values)
              _TypePreferenceSection(
                prefs: prefs,
                type: type,
              ),
          ],
        ),
      ),
    );
  }
}

class _GlobalToggle extends ConsumerWidget {
  const _GlobalToggle({required this.prefs});

  final NotificationPreferences prefs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SwitchListTile(
        title: const Text('Enable Notifications'),
        subtitle: const Text('Master toggle for all notifications'),
        value: prefs.notificationsEnabled,
        onChanged: (value) {
          ref
              .read(notificationPreferencesControllerProvider.notifier)
              .toggleNotifications(value);
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

class _TypePreferenceSection extends ConsumerWidget {
  const _TypePreferenceSection({
    required this.prefs,
    required this.type,
  });

  final NotificationPreferences prefs;
  final NotificationType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = prefs.getPreference(type);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(type.label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _ChannelToggle(
              label: 'In-App',
              icon: Icons.notifications,
              value: pref?.inAppEnabled ?? true,
              onChanged: (v) => ref
                  .read(notificationPreferencesControllerProvider.notifier)
                  .toggleChannel(type, NotificationChannel.inApp, v),
            ),
            _ChannelToggle(
              label: 'Local',
              icon: Icons.phone_android,
              value: pref?.localEnabled ?? false,
              onChanged: (v) => ref
                  .read(notificationPreferencesControllerProvider.notifier)
                  .toggleChannel(type, NotificationChannel.local, v),
            ),
            _ChannelToggle(
              label: 'Push',
              icon: Icons.cloud_outlined,
              value: pref?.pushEnabled ?? false,
              onChanged: (v) => ref
                  .read(notificationPreferencesControllerProvider.notifier)
                  .toggleChannel(type, NotificationChannel.push, v),
            ),
            _ChannelToggle(
              label: 'Email',
              icon: Icons.email_outlined,
              value: pref?.emailEnabled ?? false,
              onChanged: (v) => ref
                  .read(notificationPreferencesControllerProvider.notifier)
                  .toggleChannel(type, NotificationChannel.email, v),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelToggle extends StatelessWidget {
  const _ChannelToggle({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
