import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:accounting_app/features/crm/data/crm_repository.dart';
import 'package:accounting_app/features/crm/data/crm_repository_provider.dart';
import 'package:accounting_app/features/crm/domain/crm_task.dart';
import 'package:accounting_app/features/crm/domain/crm_tasks_controller.dart';

void main() {
  late MockCrmRepository repository;

  setUp(() {
    repository = MockCrmRepository();
  });

  group('CrmTasksController', () {
    test('fetchAll returns seeded tasks', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final tasks = await container.read(crmTasksControllerProvider().future);
      expect(tasks.length, 4);
    });

    test('createTask adds a new task', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(crmTasksControllerProvider().notifier);
      final newTask = CrmTask(
        id: 't5',
        customerId: 'c1',
        title: 'Test task',
        description: '',
        dueDate: DateTime(2026, 8, 1),
        priority: TaskPriority.high,
        status: TaskStatus.notStarted,
        assignedTo: 'user1',
        createdAt: DateTime(2026, 7, 23),
      );
      await notifier.createTask(newTask);

      final tasks = container.read(crmTasksControllerProvider()).asData?.value;
      expect(tasks, isNotNull);
      expect(tasks!.length, 5);
      expect(tasks.last.title, 'Test task');
    });

    test('updateTaskStatus changes task status', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(crmTasksControllerProvider().notifier);
      final current = (await container.read(crmTasksControllerProvider().future))
          .firstWhere((t) => t.id == 'TSK-001');
      await notifier.updateTask(current.copyWith(status: TaskStatus.completed));

      final tasks = container.read(crmTasksControllerProvider()).asData?.value;
      expect(tasks, isNotNull);
      final updated = tasks!.firstWhere((t) => t.id == 'TSK-001');
      expect(updated.status, TaskStatus.completed);
    });

    test('deleteTask removes a task', () async {
      final container = ProviderContainer(
        overrides: [
          crmRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(crmTasksControllerProvider().notifier);
      await notifier.deleteTask('TSK-001');

      final tasks = container.read(crmTasksControllerProvider()).asData?.value;
      expect(tasks, isNotNull);
      expect(tasks!.any((t) => t.id == 'TSK-001'), false);
      expect(tasks.length, 3);
    });
  });
}
