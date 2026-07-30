import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/responsive_page_scaffold.dart';
import '../domain/calendar_event.dart';
import '../domain/calendar_filter.dart';
import '../domain/event_type.dart';
import '../services/calendar_providers.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(_calendarEventsProvider);

    return ResponsivePageScaffold(
      title: 'Calendar',
      child: events.when(
        loading: () => const AppLoadingState(),
        error: (error, _) => AppErrorState(message: '$error'),
        data: (eventList) {
          if (eventList.isEmpty) {
            return const AppEmptyState(
              title: 'No upcoming events',
              message: 'Calendar events will appear from invoices, bills, and payments.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(_calendarEventsProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: eventList.length,
              itemBuilder: (context, index) {
                final event = eventList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      _iconForEventType(event.eventType),
                      color: _colorForEventType(event.eventType),
                    ),
                    title: Text(event.title),
                    subtitle: Text(event.startAt.toLocal().toString().split(' ').first),
                    trailing: Chip(label: Text(event.status.name)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  IconData _iconForEventType(EventType type) {
    switch (type) {
      case EventType.dueDate:
        return Icons.receipt;
      case EventType.payment:
        return Icons.payment;
      case EventType.meeting:
        return Icons.event;
      case EventType.task:
        return Icons.task_alt;
      case EventType.reminder:
        return Icons.notifications;
      case EventType.followUp:
        return Icons.follow_the_signs;
      case EventType.approval:
        return Icons.assignment_turned_in;
    }
  }

  Color _colorForEventType(EventType type) {
    switch (type) {
      case EventType.dueDate:
        return Colors.green;
      case EventType.payment:
        return Colors.orange;
      case EventType.meeting:
        return Colors.blue;
      case EventType.task:
        return Colors.teal;
      case EventType.reminder:
        return Colors.purple;
      case EventType.followUp:
        return Colors.indigo;
      case EventType.approval:
        return Colors.amber;
    }
  }
}

final _calendarEventsProvider = FutureProvider<List<CalendarEvent>>((ref) async {
  final service = ref.watch(calendarServiceProvider);
  final result = await service.fetchEvents(filter: const CalendarFilter());
  if (result.isSuccess) return result.data ?? [];
  throw result.error!;
});
