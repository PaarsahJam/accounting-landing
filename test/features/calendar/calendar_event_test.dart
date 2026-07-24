import 'package:accounting_app/features/calendar/domain/calendar_event.dart';
import 'package:accounting_app/features/calendar/domain/event_priority.dart';
import 'package:accounting_app/features/calendar/domain/event_status.dart';
import 'package:accounting_app/features/calendar/domain/event_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalendarEvent', () {
    final event = CalendarEvent(
      id: 'evt-1',
      title: 'Invoice INV-001 due',
      description: 'Net 30 — ACME Corp. Total: \$1,000.00',
      eventType: EventType.dueDate,
      priority: EventPriority.high,
      startAt: _mar15,
      endAt: _mar16,
      allDay: true,
      status: EventStatus.pending,
      relatedEntityType: 'salesInvoice',
      relatedEntityId: 'inv-1',
      relatedEntityLabel: 'INV-001 — ACME Corp',
    );

    test('creates instance with all fields', () {
      expect(event.id, 'evt-1');
      expect(event.title, 'Invoice INV-001 due');
      expect(event.description, 'Net 30 — ACME Corp. Total: \$1,000.00');
      expect(event.eventType, EventType.dueDate);
      expect(event.priority, EventPriority.high);
      expect(event.startAt, _mar15);
      expect(event.endAt, _mar16);
      expect(event.allDay, isTrue);
      expect(event.status, EventStatus.pending);
      expect(event.relatedEntityType, 'salesInvoice');
      expect(event.relatedEntityId, 'inv-1');
      expect(event.relatedEntityLabel, 'INV-001 — ACME Corp');
    });

    test('uses defaults for optional fields', () {
      final minimal = CalendarEvent(
        id: 'evt-2',
        title: 'Test',
        eventType: EventType.task,
        startAt: _today,
      );
      expect(minimal.priority, EventPriority.medium);
      expect(minimal.allDay, isFalse);
      expect(minimal.status, EventStatus.pending);
      expect(minimal.description, isNull);
      expect(minimal.endAt, isNull);
      expect(minimal.relatedEntityType, isNull);
      expect(minimal.relatedEntityId, isNull);
      expect(minimal.relatedEntityLabel, isNull);
    });

    test('copyWith preserves unset fields', () {
      final copied = event.copyWith(title: 'Updated title');
      expect(copied.id, 'evt-1');
      expect(copied.title, 'Updated title');
      expect(copied.eventType, EventType.dueDate);
      expect(copied.priority, EventPriority.high);
    });

    test('equality is based on id', () {
      final same = CalendarEvent(
        id: 'evt-1',
        title: 'Different title',
        eventType: EventType.task,
        startAt: _today,
      );
      expect(event == same, isTrue);
      expect(event.hashCode, same.hashCode);
    });

    test('different ids are not equal', () {
      final other = CalendarEvent(
        id: 'evt-99',
        title: 'Invoice INV-001 due',
        eventType: EventType.dueDate,
        startAt: _mar15,
      );
      expect(event == other, isFalse);
    });

    test('toString includes key fields', () {
      final str = event.toString();
      expect(str, contains('evt-1'));
      expect(str, contains('Invoice INV-001 due'));
      expect(str, contains('dueDate'));
    });
  });
}

final _today = DateTime(2026, 7, 23);
final _mar15 = DateTime(2026, 3, 15);
final _mar16 = DateTime(2026, 3, 16);
