import '../../../core/errors/app_failure.dart';
import '../../../core/errors/app_result.dart';
import '../domain/contact.dart';
import '../domain/crm_dashboard_data.dart';
import '../domain/crm_task.dart';
import '../domain/interaction.dart';
import '../domain/lead_opportunity.dart';

/// Repository for CRM operations.
abstract class CrmRepository {
  Future<AppResult<List<Contact>>> fetchContacts(String customerId);
  Future<AppResult<Contact>> createContact(Contact contact);
  Future<AppResult<Contact>> updateContact(Contact contact);
  Future<AppResult<void>> deleteContact(String id);

  Future<AppResult<List<Interaction>>> fetchInteractions(String contactId);
  Future<AppResult<Interaction>> createInteraction(Interaction interaction);
  Future<AppResult<void>> deleteInteraction(String id);

  Future<AppResult<List<CrmTask>>> fetchTasks({String? customerId});
  Future<AppResult<CrmTask>> createTask(CrmTask task);
  Future<AppResult<CrmTask>> updateTask(CrmTask task);
  Future<AppResult<void>> deleteTask(String id);

  Future<AppResult<List<LeadOpportunity>>> fetchOpportunities({
    String? customerId,
    PipelineStage? stage,
  });
  Future<AppResult<LeadOpportunity>> createOpportunity(
    LeadOpportunity opportunity,
  );
  Future<AppResult<LeadOpportunity>> updateOpportunity(
    LeadOpportunity opportunity,
  );
  Future<AppResult<void>> deleteOpportunity(String id);

  Future<AppResult<CrmDashboardData>> fetchDashboardData();
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

  final List<CrmTask> _tasks = [
    CrmTask(
      id: 'TSK-001',
      customerId: 'CUST-1001',
      contactId: 'CONT-001',
      title: 'Follow up on Q3 proposal',
      description: 'Send the revised service proposal to Ava.',
      status: TaskStatus.notStarted,
      priority: TaskPriority.high,
      dueDate: DateTime(2026, 7, 30),
      assignedTo: 'current_user',
      createdAt: DateTime(2026, 7, 23),
    ),
    CrmTask(
      id: 'TSK-002',
      customerId: 'CUST-1001',
      contactId: 'CONT-002',
      title: 'Review outstanding invoices',
      description: 'Go over the unpaid invoices with Kaveh.',
      status: TaskStatus.inProgress,
      priority: TaskPriority.urgent,
      dueDate: DateTime(2026, 7, 25),
      assignedTo: 'current_user',
      createdAt: DateTime(2026, 7, 22),
    ),
    CrmTask(
      id: 'TSK-003',
      customerId: 'CUST-1002',
      title: 'Send NDA for review',
      description: 'Send the standard NDA to Bright Labs legal team.',
      status: TaskStatus.completed,
      priority: TaskPriority.medium,
      dueDate: DateTime(2026, 7, 22),
      assignedTo: 'current_user',
      createdAt: DateTime(2026, 7, 20),
      completedAt: DateTime(2026, 7, 22),
    ),
    CrmTask(
      id: 'TSK-004',
      customerId: 'CUST-1001',
      title: 'Schedule quarterly business review',
      description: 'Book a meeting room and send calendar invites.',
      status: TaskStatus.notStarted,
      priority: TaskPriority.low,
      dueDate: DateTime(2026, 8, 5),
      assignedTo: 'current_user',
      createdAt: DateTime(2026, 7, 23),
    ),
  ];

  final List<LeadOpportunity> _opportunities = [
    LeadOpportunity(
      id: 'OPP-001',
      customerId: 'CUST-1001',
      contactId: 'CONT-001',
      title: 'Annual software license renewal',
      description:
          'Northstar wants to renew their enterprise license for 2027.',
      stage: PipelineStage.negotiation,
      estimatedValue: 45000000,
      probability: 0.8,
      expectedCloseDate: DateTime(2026, 8, 15),
      owner: 'current_user',
      createdAt: DateTime(2026, 6, 1),
    ),
    LeadOpportunity(
      id: 'OPP-002',
      customerId: 'CUST-1002',
      contactId: 'CONT-003',
      title: 'Consulting engagement Q3-Q4',
      description: 'Bright Labs is evaluating a 6-month consulting contract.',
      stage: PipelineStage.proposal,
      estimatedValue: 28000000,
      probability: 0.6,
      expectedCloseDate: DateTime(2026, 8, 30),
      owner: 'current_user',
      createdAt: DateTime(2026, 7, 10),
    ),
    LeadOpportunity(
      id: 'OPP-003',
      customerId: 'CUST-1001',
      title: 'New implementation project',
      description: 'Potential new module implementation worth 60M IRR.',
      stage: PipelineStage.qualified,
      estimatedValue: 60000000,
      probability: 0.4,
      expectedCloseDate: DateTime(2026, 9, 30),
      owner: 'current_user',
      createdAt: DateTime(2026, 7, 15),
    ),
    LeadOpportunity(
      id: 'OPP-004',
      customerId: 'CUST-1002',
      title: 'Support contract renewal',
      description: 'Annual support contract for existing modules.',
      stage: PipelineStage.won,
      estimatedValue: 12000000,
      probability: 1.0,
      expectedCloseDate: DateTime(2026, 7, 1),
      owner: 'current_user',
      createdAt: DateTime(2026, 5, 20),
      wonAt: DateTime(2026, 7, 1),
    ),
  ];

  @override
  Future<AppResult<List<Contact>>> fetchContacts(String customerId) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      return AppResult.success(
        _contacts.where((c) => c.customerId == customerId).toList(),
      );
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Contact>> createContact(Contact contact) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _contacts.add(contact);
      return AppResult.success(contact);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<Contact>> updateContact(Contact contact) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
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
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _contacts.removeWhere((c) => c.id == id);
      _interactions.removeWhere((i) => i.contactId == id);
      _tasks.removeWhere((t) => t.contactId == id);
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
      await Future<void>.delayed(const Duration(milliseconds: 200));
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
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _interactions.add(interaction);
      return AppResult.success(interaction);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteInteraction(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _interactions.removeWhere((i) => i.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<CrmTask>>> fetchTasks({String? customerId}) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      var result = _tasks.toList();
      if (customerId != null) {
        result = result.where((t) => t.customerId == customerId).toList();
      }
      result.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<CrmTask>> createTask(CrmTask task) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _tasks.add(task);
      return AppResult.success(task);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<CrmTask>> updateTask(CrmTask task) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index >= 0) {
        _tasks[index] = task;
      } else {
        _tasks.add(task);
      }
      return AppResult.success(task);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteTask(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _tasks.removeWhere((t) => t.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<List<LeadOpportunity>>> fetchOpportunities({
    String? customerId,
    PipelineStage? stage,
  }) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      var result = _opportunities.toList();
      if (customerId != null) {
        result = result.where((o) => o.customerId == customerId).toList();
      }
      if (stage != null) {
        result = result.where((o) => o.stage == stage).toList();
      }
      result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return AppResult.success(result);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<LeadOpportunity>> createOpportunity(
    LeadOpportunity opportunity,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _opportunities.add(opportunity);
      return AppResult.success(opportunity);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<LeadOpportunity>> updateOpportunity(
    LeadOpportunity opportunity,
  ) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      final index =
          _opportunities.indexWhere((o) => o.id == opportunity.id);
      if (index >= 0) {
        _opportunities[index] = opportunity;
      } else {
        _opportunities.add(opportunity);
      }
      return AppResult.success(opportunity);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<void>> deleteOpportunity(String id) async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _opportunities.removeWhere((o) => o.id == id);
      return AppResult.success(null);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<AppResult<CrmDashboardData>> fetchDashboardData() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      final now = DateTime.now();
      final data = CrmDashboardData(
        totalContacts: _contacts.length,
        totalTasks: _tasks.length,
        openTasks:
            _tasks.where((t) => t.status != TaskStatus.completed).length,
        overdueTasks: _tasks
            .where(
              (t) =>
                  t.status != TaskStatus.completed &&
                  t.status != TaskStatus.cancelled &&
                  t.dueDate.isBefore(now),
            )
            .length,
        totalLeads: _opportunities.length,
        activeOpportunities: _opportunities
            .where(
              (o) =>
                  o.stage != PipelineStage.won &&
                  o.stage != PipelineStage.lost,
            )
            .length,
        pipelineValue: _opportunities
            .where(
              (o) =>
                  o.stage != PipelineStage.won &&
                  o.stage != PipelineStage.lost,
            )
            .fold<double>(0, (sum, o) => sum + o.estimatedValue),
        wonValueThisMonth: _opportunities
            .where(
              (o) =>
                  o.stage == PipelineStage.won &&
                  o.wonAt != null &&
                  o.wonAt!.month == now.month &&
                  o.wonAt!.year == now.year,
            )
            .fold<double>(0, (sum, o) => sum + o.estimatedValue),
      );
      return AppResult.success(data);
    } catch (error) {
      return AppResult.failure(UnknownFailure(message: error.toString()));
    }
  }
}
