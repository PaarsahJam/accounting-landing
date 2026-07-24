import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/contact.dart';
import '../domain/interaction.dart';

/// Repository for CRM operations: contacts and interactions.
abstract class CrmRepository {
  Future<AppResult<List<Contact>>> fetchContacts(String customerId);
  Future<AppResult<Contact>> createContact(Contact contact);
  Future<AppResult<Contact>> updateContact(Contact contact);
  Future<AppResult<void>> deleteContact(String id);

  Future<AppResult<List<Interaction>>> fetchInteractions(String contactId);
  Future<AppResult<Interaction>> createInteraction(Interaction interaction);
  Future<AppResult<void>> deleteInteraction(String id);
}

class MockCrmRepository implements CrmRepository {
  final List<Contact> _contacts = [
    const Contact(
      id: 'CONT-001',
      customerId: 'CUST-1001',
      firstName: 'Ava',
      lastName: 'Rahimi',
      email: 'ava@northstar.co',
      phone: '+98 912 000 0001',
      jobTitle: 'CEO',
      department: 'Executive',
      isPrimary: true,
      notes: 'Main decision maker',
    ),
    const Contact(
      id: 'CONT-002',
      customerId: 'CUST-1001',
      firstName: 'Kaveh',
      lastName: 'Moradi',
      email: 'kaveh@northstar.co',
      phone: '+98 912 000 0002',
      jobTitle: 'Finance Manager',
      department: 'Finance',
      isPrimary: false,
      notes: 'Handles invoices',
    ),
    const Contact(
      id: 'CONT-003',
      customerId: 'CUST-1002',
      firstName: 'Sina',
      lastName: 'Nouri',
      email: 'sina@brightlabs.ir',
      phone: '+98 913 000 0002',
      jobTitle: 'CTO',
      department: 'Engineering',
      isPrimary: true,
      notes: 'Technical contact',
    ),
  ];

  final List<Interaction> _interactions = [
    Interaction(
      id: 'INT-001',
      contactId: 'CONT-001',
      customerId: 'CUST-1001',
      type: InteractionType.call,
      subject: 'Quarterly review call',
      description: 'Discussed outstanding invoices and upcoming projects.',
      occurredAt: DateTime(2026, 7, 20, 10, 30),
      performedBy: 'current_user',
      createdAt: DateTime(2026, 7, 20, 10, 35),
    ),
    Interaction(
      id: 'INT-002',
      contactId: 'CONT-001',
      customerId: 'CUST-1001',
      type: InteractionType.email,
      subject: 'Invoice follow-up',
      description: 'Sent payment reminder for SI-2026-000015.',
      occurredAt: DateTime(2026, 7, 18, 14, 0),
      performedBy: 'current_user',
      createdAt: DateTime(2026, 7, 18, 14, 5),
    ),
    Interaction(
      id: 'INT-003',
      contactId: 'CONT-002',
      customerId: 'CUST-1001',
      type: InteractionType.meeting,
      subject: 'On-site meeting',
      description: 'Walked through monthly reconciliation reports.',
      occurredAt: DateTime(2026, 7, 15, 9, 0),
      performedBy: 'current_user',
      createdAt: DateTime(2026, 7, 15, 11, 0),
    ),
    Interaction(
      id: 'INT-004',
      contactId: 'CONT-003',
      customerId: 'CUST-1002',
      type: InteractionType.note,
      subject: 'General note',
      description: 'Customer requested a proposal for Q3 services.',
      occurredAt: DateTime(2026, 7, 22, 16, 45),
      performedBy: 'current_user',
      createdAt: DateTime(2026, 7, 22, 16, 45),
    ),
  ];

  @override
  Future<AppResult<List<Contact>>> fetchContacts(String customerId) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final result = _contacts.where((c) => c.customerId == customerId).toList();
      return AppResult.success(List<Contact>.from(result));
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Contact>> createContact(Contact contact) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _contacts.add(contact);
      return AppResult.success(contact);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Contact>> updateContact(Contact contact) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final index = _contacts.indexWhere((c) => c.id == contact.id);
      if (index >= 0) {
        _contacts[index] = contact;
      } else {
        _contacts.add(contact);
      }
      return AppResult.success(contact);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteContact(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _contacts.removeWhere((c) => c.id == id);
      _interactions.removeWhere((i) => i.contactId == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<Interaction>>> fetchInteractions(
    String contactId,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      final result = _interactions
          .where((i) => i.contactId == contactId)
          .toList()
        ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Interaction>> createInteraction(
    Interaction interaction,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _interactions.add(interaction);
      return AppResult.success(interaction);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteInteraction(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      _interactions.removeWhere((i) => i.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
