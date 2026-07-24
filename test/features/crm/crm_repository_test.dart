import 'package:accounting_app/features/crm/data/crm_repository.dart';
import 'package:accounting_app/features/crm/domain/contact.dart';
import 'package:accounting_app/features/crm/domain/interaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MockCrmRepository', () {
    late MockCrmRepository repo;

    setUp(() {
      repo = MockCrmRepository();
    });

    test('fetchContacts returns contacts for a given customer', () async {
      final result = await repo.fetchContacts('CUST-1001');

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.every((c) => c.customerId == 'CUST-1001'), isTrue);
    });

    test('fetchContacts returns empty list for unknown customer', () async {
      final result = await repo.fetchContacts('UNKNOWN');

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('createContact adds a new contact', () async {
      final contact = Contact(
        id: 'CONT-NEW',
        customerId: 'CUST-1001',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        phone: '+98 900 000 0000',
        jobTitle: 'Tester',
        department: 'QA',
        isPrimary: false,
        notes: '',
      );

      final createResult = await repo.createContact(contact);
      expect(createResult.isSuccess, isTrue);

      final fetchResult = await repo.fetchContacts('CUST-1001');
      expect(fetchResult.data!.any((c) => c.id == 'CONT-NEW'), isTrue);
    });

    test('updateContact modifies existing contact', () async {
      final updated = Contact(
        id: 'CONT-001',
        customerId: 'CUST-1001',
        firstName: 'Ava',
        lastName: 'Rahimi-Updated',
        email: 'ava.new@northstar.co',
        phone: '+98 912 000 0001',
        jobTitle: 'CEO',
        department: 'Executive',
        isPrimary: true,
        notes: 'Updated notes',
      );

      final result = await repo.updateContact(updated);
      expect(result.isSuccess, isTrue);

      final fetchResult = await repo.fetchContacts('CUST-1001');
      final contact = fetchResult.data!.firstWhere((c) => c.id == 'CONT-001');
      expect(contact.lastName, 'Rahimi-Updated');
      expect(contact.email, 'ava.new@northstar.co');
    });

    test('deleteContact removes contact and its interactions', () async {
      final result = await repo.deleteContact('CONT-001');
      expect(result.isSuccess, isTrue);

      final contacts = await repo.fetchContacts('CUST-1001');
      expect(contacts.data!.any((c) => c.id == 'CONT-001'), isFalse);

      final interactions = await repo.fetchInteractions('CONT-001');
      expect(interactions.data, isEmpty);
    });

    test('fetchInteractions returns interactions for a contact', () async {
      final result = await repo.fetchInteractions('CONT-001');

      expect(result.isSuccess, isTrue);
      expect(result.data, isNotEmpty);
      expect(result.data!.every((i) => i.contactId == 'CONT-001'), isTrue);
    });

    test('fetchInteractions returns empty for unknown contact', () async {
      final result = await repo.fetchInteractions('UNKNOWN');

      expect(result.isSuccess, isTrue);
      expect(result.data, isEmpty);
    });

    test('createInteraction adds a new interaction', () async {
      final interaction = Interaction(
        id: 'INT-NEW',
        contactId: 'CONT-001',
        customerId: 'CUST-1001',
        type: InteractionType.email,
        subject: 'Test subject',
        description: 'Test description',
        occurredAt: DateTime(2026, 7, 23),
        performedBy: 'tester',
        createdAt: DateTime(2026, 7, 23),
      );

      final result = await repo.createInteraction(interaction);
      expect(result.isSuccess, isTrue);

      final fetchResult = await repo.fetchInteractions('CONT-001');
      expect(fetchResult.data!.any((i) => i.id == 'INT-NEW'), isTrue);
    });

    test('deleteInteraction removes an interaction', () async {
      final result = await repo.deleteInteraction('INT-001');
      expect(result.isSuccess, isTrue);

      final fetchResult = await repo.fetchInteractions('CONT-001');
      expect(fetchResult.data!.any((i) => i.id == 'INT-001'), isFalse);
    });

    test('interactions are sorted by occurredAt descending', () async {
      final result = await repo.fetchInteractions('CONT-001');

      expect(result.isSuccess, isTrue);
      final interactions = result.data!;
      for (var i = 0; i < interactions.length - 1; i++) {
        expect(
          interactions[i].occurredAt.isAfter(interactions[i + 1].occurredAt) ||
              interactions[i].occurredAt == interactions[i + 1].occurredAt,
          isTrue,
        );
      }
    });
  });
}
