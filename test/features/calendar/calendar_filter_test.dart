import 'package:accounting_app/features/calendar/domain/calendar_event.dart';
import 'package:accounting_app/features/calendar/domain/calendar_filter.dart';
import 'package:accounting_app/features/calendar/domain/event_priority.dart';
import 'package:accounting_app/features/calendar/domain/event_status.dart';
import 'package:accounting_app/features/calendar/domain/event_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final invoiceEvent = CalendarEvent(
    id: '1',
    title: 'Invoice INV-001 due',
    eventType: EventType.dueDate,
    priority: EventPriority.high,
    startAt: _feb14,
    status: EventStatus.pending,
    relatedEntityType: 'salesInvoice',
    relatedEntityId: 'inv-1',
  );

  final paymentEvent = CalendarEvent(
    id: '2',
    title: 'Payment received from ACME',
    eventType: EventType.payment,
    priority: EventPriority.medium,
    startAt: _feb01,
    status: EventStatus.completed,
    relatedEntityType: 'customerPayment',
    relatedEntityId: 'cp-1',
  );

  final reminderEvent = CalendarEvent(
    id: '3',
    title: 'Review quarterly report',
    eventType: EventType.reminder,
    priority: EventPriority.low,
    startAt: _mar15,
    status: EventStatus.pending,
  );

  group('CalendarFilter.none', () {
    test('matches all events', () {
      expect(CalendarFilter.none.matches(invoiceEvent), isTrue);
      expect(CalendarFilter.none.matches(paymentEvent), isTrue);
      expect(CalendarFilter.none.matches(reminderEvent), isTrue);
    });
  });

  group('filtering by eventType', () {
    test('matches events of specified type', () {
      const filter = CalendarFilter(eventTypes: [EventType.dueDate]);
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
      expect(filter.matches(reminderEvent), isFalse);
    });

    test('matches events matching any of multiple types', () {
      const filter = CalendarFilter(
        eventTypes: [EventType.dueDate, EventType.payment],
      );
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isTrue);
      expect(filter.matches(reminderEvent), isFalse);
    });

    test('empty list excludes everything', () {
      const filter = CalendarFilter(eventTypes: []);
      expect(filter.matches(invoiceEvent), isFalse);
      expect(filter.matches(paymentEvent), isFalse);
    });
  });

  group('filtering by priority', () {
    test('matches events of specified priority', () {
      const filter = CalendarFilter(priorities: [EventPriority.high]);
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
    });
  });

  group('filtering by status', () {
    test('matches events of specified status', () {
      const filter = CalendarFilter(statuses: [EventStatus.completed]);
      expect(filter.matches(paymentEvent), isTrue);
      expect(filter.matches(invoiceEvent), isFalse);
    });
  });

  group('filtering by date range', () {
    test('from filter excludes earlier events', () {
      final filter = CalendarFilter(from: _feb14);
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
    });

    test('to filter excludes later events', () {
      final filter = CalendarFilter(to: _feb14);
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(reminderEvent), isFalse);
    });

    test('from and to create a range', () {
      final filter = CalendarFilter(from: _feb01, to: _feb28);
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isTrue);
      expect(filter.matches(reminderEvent), isFalse);
    });
  });

  group('filtering by related entity', () {
    test('matches events of specified entity type', () {
      const filter = CalendarFilter(relatedEntityType: 'salesInvoice');
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
    });

    test('matches events of specified entity id', () {
      const filter = CalendarFilter(relatedEntityId: 'cp-1');
      expect(filter.matches(paymentEvent), isTrue);
      expect(filter.matches(invoiceEvent), isFalse);
    });

    test('matches events matching both type and id', () {
      const filter = CalendarFilter(
        relatedEntityType: 'salesInvoice',
        relatedEntityId: 'inv-1',
      );
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);

      const wrongId = CalendarFilter(
        relatedEntityType: 'salesInvoice',
        relatedEntityId: 'wrong-id',
      );
      expect(wrongId.matches(invoiceEvent), isFalse);
    });
  });

  group('filtering by search query', () {
    test('matches on title case-insensitively', () {
      const filter = CalendarFilter(searchQuery: 'invoice');
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
    });

    test('empty search query matches everything', () {
      const filter = CalendarFilter(searchQuery: '');
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isTrue);
    });
  });

  group('multi-axis filtering', () {
    test('combines type and status', () {
      final filter = CalendarFilter(
        eventTypes: [EventType.dueDate],
        statuses: [EventStatus.pending],
      );
      expect(filter.matches(invoiceEvent), isTrue);
      expect(filter.matches(paymentEvent), isFalse);
      expect(filter.matches(reminderEvent), isFalse);
    });

    test('combines type, priority, and date range', () {
      final filter = CalendarFilter(
        eventTypes: [EventType.dueDate],
        priorities: [EventPriority.high],
        from: _feb01,
        to: _feb28,
      );
      expect(filter.matches(invoiceEvent), isTrue);

      final wrongPriority = CalendarFilter(
        eventTypes: [EventType.dueDate],
        priorities: [EventPriority.medium],
      );
      expect(wrongPriority.matches(invoiceEvent), isFalse);
    });
  });
}

final _feb01 = DateTime(2026, 2, 1);
final _feb14 = DateTime(2026, 2, 14);
final _feb28 = DateTime(2026, 2, 28);
final _mar15 = DateTime(2026, 3, 15);
