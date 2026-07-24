import 'package:accounting_app/features/crm/data/crm_repository.dart';
import 'package:accounting_app/features/crm/data/crm_repository_provider.dart';
import 'package:accounting_app/features/crm/domain/contact.dart';
import 'package:accounting_app/features/crm/domain/contacts_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(MockCrmRepository()),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('loads contacts for a customer successfully', () async {
      final controller =
          container.read(contactsControllerProvider('CUST-1001').notifier);
      final result = await controller.future;

      expect(result, isNotEmpty);
      expect(result.first.firstName, isNotEmpty);
    });

    test('returns empty list for unknown customer', () async {
      final controller =
          container.read(contactsControllerProvider('UNKNOWN').notifier);
      final result = await controller.future;

      expect(result, isEmpty);
    });

    test('createContact adds contact to state', () async {
      final provider = contactsControllerProvider('CUST-1001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      final newContact = Contact(
        id: 'CONT-NEW',
        customerId: 'CUST-1001',
        firstName: 'New',
        lastName: 'Contact',
        email: 'new@example.com',
        phone: '+98 900 000 0000',
        jobTitle: 'Manager',
        department: 'Sales',
        isPrimary: false,
        notes: '',
      );

      await controller.createContact(newContact);

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value!.any((c) => c.id == 'CONT-NEW'), isTrue);
    });

    test('updateContact modifies contact in state', () async {
      final provider = contactsControllerProvider('CUST-1001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

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
        notes: 'Updated',
      );

      await controller.updateContact(updated);

      final current = controller.state;
      expect(current.hasValue, isTrue);
      final contact = current.value!.firstWhere((c) => c.id == 'CONT-001');
      expect(contact.lastName, 'Rahimi-Updated');
    });

    test('deleteContact removes contact from state', () async {
      final provider = contactsControllerProvider('CUST-1001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      await controller.deleteContact('CONT-001');

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value!.any((c) => c.id == 'CONT-001'), isFalse);
    });

    test('refresh reloads contacts', () async {
      final provider = contactsControllerProvider('CUST-1001');
      final sub = container.listen(provider, (prev, next) {});
      addTearDown(() => sub.close());

      final controller = container.read(provider.notifier);
      await controller.future;

      await controller.refresh();

      final current = controller.state;
      expect(current.hasValue, isTrue);
      expect(current.value, isNotEmpty);
    });

    test('separate customer scopes are isolated', () async {
      final p1 = contactsControllerProvider('CUST-1001');
      final p2 = contactsControllerProvider('CUST-1002');
      final s1 = container.listen(p1, (prev, next) {});
      final s2 = container.listen(p2, (prev, next) {});
      addTearDown(() { s1.close(); s2.close(); });

      await container.read(p1.notifier).future;
      await container.read(p2.notifier).future;

      final r1 = container.read(p1.notifier);
      final r2 = container.read(p2.notifier);

      expect(r1.state.hasValue, isTrue);
      expect(r2.state.hasValue, isTrue);
      expect(r1.state.value!.every((c) => c.customerId == 'CUST-1001'), isTrue);
      expect(r2.state.value!.every((c) => c.customerId == 'CUST-1002'), isTrue);
    });
  });
}
